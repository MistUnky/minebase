-- carts_api/init.lua

local S = minetest.get_translator("carts_api")

carts = {}
carts.railparams = {}

-- Maximal speed of the cart in m/s (min = -1)
carts.speed_max = 7
-- Set to -1 to disable punching the cart from inside (min = -1)
carts.punch_speed_max = 5
-- Maximal distance for the path correction (for dtime peaks)
carts.path_distance_max = 3

function carts.get_sign(z)
	return z == 0 and 0 or z / math.abs(z)
end

function carts.manage_attachment(player, obj)
	if not player then
		return
	end
	local status = obj ~= nil
	local player_name = player:get_player_name()
	if players.player_attached[player_name] == status then
		return
	end
	players.player_attached[player_name] = status

	if status then
		player:set_attach(obj, "", {x=0, y=-4.5, z=0}, {x=0, y=0, z=0})
		player:set_eye_offset({x=0, y=-4, z=0},{x=0, y=-4, z=0})
	else
		player:set_detach()
		player:set_eye_offset({x=0, y=0, z=0},{x=0, y=0, z=0})
	end
end

function carts.velocity_to_dir(v)
	if math.abs(v.x) > math.abs(v.z) then
		return {x=carts.get_sign(v.x), y=carts.get_sign(v.y), z=0}
	else
		return {x=0, y=carts.get_sign(v.y), z=carts.get_sign(v.z)}
	end
end

function carts.is_rail(pos, railtype)
	local node = minetest.get_node(pos).name
	if node == "ignore" then
		local vm = minetest.get_voxel_manip()
		local emin, emax = vm:read_from_map(pos, pos)
		local area = VoxelArea:new{
			MinEdge = emin,
			MaxEdge = emax,
		}
		local data = vm:get_data()
		local vi = area:indexp(pos)
		node = minetest.get_name_from_content_id(data[vi])
	end
	if minetest.get_item_group(node, "rail") == 0 then
		return false
	end
	if not railtype then
		return true
	end
	return minetest.get_item_group(node, "connect_to_raillike") == railtype
end

function carts.check_front_up_down(pos, dir_, check_up, railtype)
	local dir = vector.new(dir_)
	local cur

	-- Front
	dir.y = 0
	cur = vector.add(pos, dir)
	if carts.is_rail(cur, railtype) then
		return dir
	end
	-- Up
	if check_up then
		dir.y = 1
		cur = vector.add(pos, dir)
		if carts.is_rail(cur, railtype) then
			return dir
		end
	end
	-- Down
	dir.y = -1
	cur = vector.add(pos, dir)
	if carts.is_rail(cur, railtype) then
		return dir
	end
	return nil
end

function carts.get_rail_direction(self, pos_, dir, ctrl, old_switch, railtype)
	local pos = vector.round(pos_)
	local cur
	local left_check, right_check = true, true

	-- Check left and right
	local left = {x=0, y=0, z=0}
	local right = {x=0, y=0, z=0}
	if dir.z ~= 0 and dir.x == 0 then
		left.x = -dir.z
		right.x = dir.z
	elseif dir.x ~= 0 and dir.z == 0 then
		left.z = dir.x
		right.z = -dir.x
	end

	local straight_priority = ctrl and dir.y ~= 0

	-- Normal, to disallow rail switching up- & downhill
	if straight_priority then
		cur = self.check_front_up_down(pos, dir, true, railtype)
		if cur then
			return cur
		end
	end

	if ctrl then
		if old_switch == 1 then
			left_check = false
		elseif old_switch == 2 then
			right_check = false
		end
		if ctrl.left and left_check then
			cur = self.check_front_up_down(pos, left, false, railtype)
			if cur then
				return cur, 1
			end
			left_check = false
		end
		if ctrl.right and right_check then
			cur = self.check_front_up_down(pos, right, false, railtype)
			if cur then
				return cur, 2
			end
			right_check = true
		end
	end

	-- Normal
	if not straight_priority then
		cur = self.check_front_up_down(pos, dir, true, railtype)
		if cur then
			return cur
		end
	end

	-- Left, if not already checked
	if left_check then
		cur = carts.check_front_up_down(pos, left, false, railtype)
		if cur then
			return cur
		end
	end

	-- Right, if not already checked
	if right_check then
		cur = carts.check_front_up_down(pos, right, false, railtype)
		if cur then
			return cur
		end
	end

	-- Backwards
	if not old_switch then
		cur = carts.check_front_up_down(pos, {
				x = -dir.x,
				y = dir.y,
				z = -dir.z
			}, true, railtype)
		if cur then
			return cur
		end
	end

	return {x=0, y=0, z=0}
end

function carts.pathfinder(self, pos_, old_pos, old_dir, distance, ctrl,
		pf_switch, railtype)

	local pos = vector.round(pos_)
	if vector.equals(old_pos, pos) then
		return
	end

	local pf_pos = vector.round(old_pos)
	local pf_dir = vector.new(old_dir)
	distance = math.min(carts.path_distance_max, math.floor(distance + 1))

	for i = 1, distance do
		pf_dir, pf_switch = carts.get_rail_direction(self, pf_pos, pf_dir, ctrl, 
			pf_switch or 0, railtype)

		if vector.equals(pf_dir, {x=0, y=0, z=0}) then
			-- No way forwards
			return pf_pos, pf_dir
		end

		pf_pos = vector.add(pf_pos, pf_dir)

		if vector.equals(pf_pos, pos) then
			-- Success! Cart moved on correctly
			return
		end
	end
	-- Not found. Put cart to predicted position
	return pf_pos, pf_dir
end

function carts.get_rail_groups(groups)
	groups = groups and table.copy(groups) or {dig_immediate = 2}
	groups.attached_node = 1
	groups.rail = 1
	groups.connect_to_raillike = minetest.raillike_group("rail")
	return groups
end

-- sound refresh interval = 1.0sec
function carts.rail_sound(self, dtime)
	if not self.sound_ttl then
		self.sound_ttl = 1.0
		return
	elseif self.sound_ttl > 0 then
		self.sound_ttl = self.sound_ttl - dtime
		return
	end
	self.sound_ttl = 1.0
	if self.sound_handle then
		local handle = self.sound_handle
		self.sound_handle = nil
		minetest.after(0.2, minetest.sound_stop, handle)
	end
	local vel = self.object:get_velocity()
	local speed = vector.length(vel)
	if speed > 0 then
		self.sound_handle = minetest.sound_play(
			"carts_api_moving", {
			object = self.object,
			gain = (speed / carts.speed_max) / 2,
			loop = true,
		})
	end
end

local function get_railparams(pos)
	return carts.railparams[minetest.get_node(pos).name] or {}
end

local function rail_on_step_event(handler, obj, dtime)
	if handler then
		return handler(obj, dtime)
	end
end

local function determineYaw(old_dir)
	local new = 0
	if old_dir.x < 0 then
		new = 0.5
	elseif old_dir.x > 0 then
		new = 1.5
	elseif old_dir.z < 0 then
		new = 1
	end
	return new * math.pi
end

local v3_len = vector.length
local anims = {[-1] = {x = 1, y = 1}, [0] = {x = 0, y = 0}, {x = 2, y = 2}}
function carts.rail_on_step(self, dtime)
	local vel = self.object:get_velocity()
	if self._punched then
		vel = vector.add(vel, self._velocity)
		self.object:set_velocity(vel)
		self._old_dir.y = 0
	elseif vector.equals(vel, {x=0, y=0, z=0}) then
		return
	end

	local pos = self.object:get_pos()
	local cart_dir = carts.velocity_to_dir(vel)
	local same_dir = vector.equals(cart_dir, self._old_dir)
	local update = {}

	if self._old_pos and not self._punched and same_dir then
		local flo_pos = vector.round(pos)
		local flo_old = vector.round(self._old_pos)
		if vector.equals(flo_pos, flo_old) then
			-- Do not check one node multiple times
			return
		end
	end

	local ctrl, player

	-- Get player controls
	if self._driver then
		player = minetest.get_player_by_name(self._driver)
		if player then
			ctrl = player:get_player_control()
		end
	end

	local stop_wiggle = false
	if self._old_pos and same_dir then
		-- Detection for "skipping" nodes (perhaps use average dtime?)
		-- It's sophisticated enough to take the acceleration in account
		local acc = self.object:get_acceleration()
		local distance = dtime * (v3_len(vel) + 0.5 * dtime * v3_len(acc))

		local new_pos, new_dir = carts:pathfinder(
			pos, self._old_pos, self._old_dir, distance, ctrl,
			self._old_switch, self._railtype
		)

		if new_pos then
			-- No rail found: set to the expected position
			pos = new_pos
			update.pos = true
			cart_dir = new_dir
		end
	elseif self._old_pos and self._old_dir.y ~= 1 and not self._punched then
		-- Stop wiggle
		stop_wiggle = true
	end

	local railparams

	-- dir:         New moving direction of the cart
	-- switch_keys: Currently pressed L/R key, used to ignore the key on the next rail node
	local dir, switch_keys = carts:get_rail_direction(
		pos, cart_dir, ctrl, self._old_switch, self._railtype
	)
	local dir_changed = not vector.equals(dir, self._old_dir)

	local new_acc = {x=0, y=0, z=0}
	if stop_wiggle or vector.equals(dir, {x=0, y=0, z=0}) then
		vel = {x = 0, y = 0, z = 0}
		local pos_r = vector.round(pos)
		if not carts.is_rail(pos_r, self._railtype)
				and self._old_pos then
			pos = self._old_pos
		elseif not stop_wiggle then
			pos = pos_r
		else
			pos.y = math.floor(pos.y + 0.5)
		end
		update.pos = true
		update.vel = true
	else
		-- Direction change detected
		if dir_changed then
			vel = vector.multiply(dir, math.abs(vel.x + vel.z))
			update.vel = true
			if dir.y ~= self._old_dir.y then
				pos = vector.round(pos)
				update.pos = true
			end
		end
		-- Center on the rail
		if dir.z ~= 0 and math.floor(pos.x + 0.5) ~= pos.x then
			pos.x = math.floor(pos.x + 0.5)
			update.pos = true
		end
		if dir.x ~= 0 and math.floor(pos.z + 0.5) ~= pos.z then
			pos.z = math.floor(pos.z + 0.5)
			update.pos = true
		end

		-- Slow down or speed up..
		local acc = dir.y * -4.0

		-- Get rail for corrected position
		railparams = get_railparams(pos)

		-- no need to check for railparams == nil since we always make it exist.
		local speed_mod = railparams.acceleration
		if speed_mod and speed_mod ~= 0 then
			-- Try to make it similar to the original carts mod
			acc = acc + speed_mod
		else
			-- Handbrake or coast
			if ctrl and ctrl.down then
				acc = acc - 3
			else
				acc = acc - 0.4
			end
		end

		new_acc = vector.multiply(dir, acc)
	end

	-- Limits
	local max_vel = carts.speed_max
	for _, v in pairs({"x","y","z"}) do
		if math.abs(vel[v]) > max_vel then
			vel[v] = carts.get_sign(vel[v]) * max_vel
			new_acc[v] = 0
			update.vel = true
		end
	end

	self.object:set_acceleration(new_acc)
	self._old_pos = vector.round(pos)
	if not vector.equals(dir, {x=0, y=0, z=0}) and not stop_wiggle then
		self._old_dir = vector.new(dir)
	end
	self._old_switch = switch_keys

	if self._punched then
		-- Collect dropped items
		for _, obj_ in pairs(minetest.get_objects_inside_radius(pos, 1)) do
			local ent = obj_:get_luaentity()
			-- Careful here: physical_state and disable_physics are item-internal APIs
			if ent and ent.name == "__builtin:item" and ent.physical_state then
				ent:disable_physics()
				obj_:set_attach(self.object, "", {x=0, y=0, z=0}, {x=0, y=0, z=0})
				self._attached_items[#self._attached_items + 1] = obj_
			end
		end
		self._punched = false
		update.vel = true
	end

	railparams = railparams or get_railparams(pos)

	if not (update.vel or update.pos) then
		rail_on_step_event(railparams.on_step, self, dtime)
		return
	end

	self.object:set_yaw(determineYaw(self._old_dir))
	self.object:set_animation(anims[dir.y], 1, 0)

	if update.vel then
		self.object:set_velocity(vel)
	end
	if update.pos then
		if dir_changed then
			self.object:set_pos(pos)
		else
			self.object:move_to(pos)
		end
	end

	-- call event handler
	rail_on_step_event(railparams.on_step, self, dtime)
end

function carts.on_step(self, dtime)
	carts.rail_on_step(self, dtime)
	carts.rail_sound(self, dtime)
end

function carts.on_rightclick(self, clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	local player_name = clicker:get_player_name()
	if self._driver and player_name == self._driver then
		self._driver = nil
		carts.manage_attachment(clicker, nil)
	elseif not self._driver then
		self._driver = player_name
		carts.manage_attachment(clicker, self.object)

		-- player_api does not update the animation
		-- when the player is attached, reset to default animation
		players.set_animation(clicker, "stand")
	end
end

function carts.on_activate(self, staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	if string.sub(staticdata, 1, string.len("return")) ~= "return" then
		return
	end
	local data = minetest.deserialize(staticdata)
	if type(data) ~= "table" then
		return
	end
	self._railtype = data._railtype
	if data._old_dir then
		self._old_dir = data._old_dir
	end
end

function carts.get_staticdata(self)
	return minetest.serialize({
		_railtype = self._railtype,
		_old_dir = self._old_dir
	})
end

-- 0.5.x and later: When the driver leaves
function carts.on_detach_child(self, child)
	if child and child:get_player_name() == self._driver then
		self._driver = nil
		carts.manage_attachment(child, nil)
	end
end

function carts.on_punch(self, puncher, time_from_last_punch, tool_capabilities, 
	direction)
	local pos = self.object:get_pos()
	local vel = self.object:get_velocity()
	if not self._railtype or vector.equals(vel, {x=0, y=0, z=0}) then
		local node = minetest.get_node(pos).name
		self._railtype = minetest.get_item_group(node, "connect_to_raillike")
	end
	-- Punched by non-player
	if not puncher or not puncher:is_player() then
		local cart_dir = carts:get_rail_direction(pos, self._old_dir, nil, nil, 
			self._railtype)
		if vector.equals(cart_dir, {x=0, y=0, z=0}) then
			return
		end
		self._velocity = vector.multiply(cart_dir, 2)
		self._punched = true
		return
	end
	-- Player digs cart by aux1-punch
	if puncher:get_player_control().aux1 then
		if self.sound_handle then
			minetest.sound_stop(self.sound_handle)
		end
		-- Detach driver and items
		if self._driver then
			if self._old_pos then
				self.object:set_pos(self._old_pos)
			end
			local player = minetest.get_player_by_name(self._driver)
			carts.manage_attachment(player, nil)
		end
		for _, obj_ in ipairs(self._attached_items) do
			if obj_ then
				obj_:set_detach()
			end
		end
		-- Pick up cart
		local inv = puncher:get_inventory()
		if not minetest.is_creative_enabled(puncher:get_player_name())
				or not inv:contains_item("main", self._name) then
			local leftover = inv:add_item("main", self._name)
			-- If no room in inventory add a replacement cart to the world
			if not leftover:is_empty() then
				minetest.add_item(self.object:get_pos(), leftover)
			end
		end
		self.object:remove()
		return
	end
	-- Player punches cart to alter velocity
	if puncher:get_player_name() == self._driver then
		if math.abs(vel.x + vel.z) > carts.punch_speed_max then
			return
		end
	end

	local punch_dir = carts.velocity_to_dir(puncher:get_look_dir())
	punch_dir.y = 0
	local cart_dir = carts:get_rail_direction(pos, punch_dir, nil, nil, 
		self._railtype)
	if vector.equals(cart_dir, {x=0, y=0, z=0}) then
		return
	end

	local punch_interval = 1
	if tool_capabilities and tool_capabilities.full_punch_interval then
		punch_interval = tool_capabilities.full_punch_interval
	end
	time_from_last_punch = math.min(time_from_last_punch or punch_interval, 
		punch_interval)
	local f = 2 * (time_from_last_punch / punch_interval)

	self._velocity = vector.multiply(cart_dir, f)
	self._old_dir = cart_dir
	self._punched = true
end

function carts.craftitem_on_place(itemstack, placer, pointed_thing)
	local under = pointed_thing.under
	local node = minetest.get_node(under)
	local udef = minetest.registered_nodes[node.name]
	if udef and udef.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
		return udef.on_rightclick(under, node, placer, itemstack,
			pointed_thing) or itemstack
	end

	if not pointed_thing.type == "node" then
		return
	end
	if carts.is_rail(pointed_thing.under) then
		minetest.add_entity(pointed_thing.under, itemstack:get_name())
	elseif carts.is_rail(pointed_thing.above) then
		minetest.add_entity(pointed_thing.above, itemstack:get_name())
	else
		return
	end

	minetest.sound_play({name = "ores_api_place_node_metal", gain = 0.5},
		{pos = pointed_thing.above}, true)

	if not minetest.is_creative_enabled(placer:get_player_name()) then
		itemstack:take_item()
	end
	return itemstack
end

function carts.register_rail(name, def)
	if def.railparams then
		carts.railparams[name] = table.copy(def.railparams)
	end

	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description,
		tiles = def.tiles or {
			txt .. "_straight.png", txt .. "_curved.png",
			txt .. "_t_junction.png", txt .. "_crossing.png"
		},
		groups = carts.get_rail_groups(def.groups),
		drawtype = "raillike",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		walkable = def.walkable or false,
		wield_image = def.wield_image or txt .. "_straight.png",
		inventory_image = def.inventory_image or txt .. "_straight.png",
		selection_box = def.selection_box or {
			type = "fixed",
			fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
		},
		sounds = def.sounds or sounds.get_defaults("ore_sounds:metal"),
	})

	if def.recipe then
		minetest.register_craft({
			output = name .. " 18",
			recipe = def.recipe 
		})
	end
end

function carts.register_entity(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_entity(name, {
		initial_properties = {
			infotext = S("left-click push, right-click mount") .. "\n" 
				.. S("aux + left-click to pick up"),
			physical = false, -- otherwise going uphill breaks
			collisionbox = def.collisionbox or {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			visual = def.visual or "mesh",
			mesh = def.mesh or "carts_api_cart.b3d",
			visual_size = def.visual_size or {x=1, y=1},
			textures = def.textures or {txt .. ".png"},
		},
		on_step = def.on_step or carts.on_step, 
		on_rightclick = def.on_rightclick or carts.on_rightclick,
		on_activate = def.on_activate or carts.on_activate,
		get_staticdata = def.get_staticdata or carts.get_staticdata,
		on_detach_child = def.on_detach_child or carts.on_detach_child,
		on_punch = def.on_punch or carts.on_punch,
		_driver = nil,
		_punched = false, -- used to re-send velocity and position
		_velocity = {x=0, y=0, z=0}, -- only used on punch
		_old_dir = {x=1, y=0, z=0}, -- random value to start the cart on punch
		_old_pos = nil,
		_old_switch = 0,
		_railtype = def.railtype,
		_attached_items = def.attached_items or {},
		_name = name
	})
end

function carts.register_craftitem(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_craftitem(name, {
		description = def.description,
		inventory_image = def.inventory_image or minetest.inventorycube(txt 
			.. "_top.png", txt .. "_front.png", txt .. "_side.png"),
		wield_image = def.wield_image or txt .. "_front.png",
		on_place = def.on_place or carts.craftitem_on_place,
	})

	if def.recipe then
		minetest.register_craft({
			output = name,
			recipe = def.recipe
		})
	end
end

function carts.register_cart(name, def)
	carts.register_entity(name, def.entity or {})

	if def.craftitem then
		carts.register_craftitem(name, def.craftitem)
	end
end
