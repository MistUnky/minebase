lib_mount = {
	passengers = {}
}

local crash_threshold = 6.5		-- ignored if enable_crash is disabled

------------------------------------------------------------------------------

local function node_is(pos)
	local node = minetest.get_node(pos)
	if node.name == "air" then
		return "air"
	end
	if minetest.get_item_group(node.name, "liquid") ~= 0 then
		return "liquid"
	end
	if minetest.get_item_group(node.name, "walkable") ~= 0 then
		return "walkable"
	end
	return "other"
end

local function get_sign(i)
	i = i or 0
	if i == 0 then
		return 0
	else
		return i / math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = -math.sin(yaw) * v
	local z =  math.cos(yaw) * v
	return {x = x, y = y, z = z}
end

local function get_v(v)
	return math.sqrt(v.x ^ 2 + v.z ^ 2)
end

local function force_detach(player)
	local attached_to = player:get_attach()
	if attached_to then
		local entity = attached_to:get_luaentity()
		if entity.driver and entity.driver == player then
			entity.driver = nil
		elseif entity.passenger and entity.passenger == player then
			entity.passenger = nil
			lib_mount.passengers[player] = nil
		elseif entity.passenger2 and entity.passenger2 == player then
			entity.passenger2 = nil
			lib_mount.passengers[player] = nil
		elseif entity.passenger3 and entity.passenger3 == player then
			entity.passenger3 = nil
			lib_mount.passengers[player] = nil
		end
		player:set_detach()
		players.player_attached[player:get_player_name()] = false
		player:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
	end
end

-------------------------------------------------------------------------------

minetest.register_on_leaveplayer(function(player)
	force_detach(player)
end)

minetest.register_on_shutdown(function()
    local players = minetest.get_connected_players()
	for i = 1,#players do
		force_detach(players[i])
	end
end)

minetest.register_on_dieplayer(function(player)
	force_detach(player)
	return true
end)

-------------------------------------------------------------------------------

function lib_mount.attach(entity, player, is_passenger, passenger_number)
	local attach_at, eye_offset = {}, {}

	if not is_passenger then
		passenger_number = nil
	end

	if not entity.player_rotation then
		entity.player_rotation = {x=0, y=0, z=0}
	end

	local rot_view = 0
	if entity.player_rotation.y == 90 then
		rot_view = math.pi/2
	end

	if is_passenger == true and passenger_number == 1 then
		if not entity.passenger_attach_at then
			entity.passenger_attach_at = {x=0, y=0, z=0}
		end
		if not entity.passenger_eye_offset then
			entity.passenger_eye_offset = {x=0, y=0, z=0}
		end

		attach_at = entity.passenger_attach_at
		eye_offset = entity.passenger_eye_offset

		entity.passenger = player
		lib_mount.passengers[entity.passenger] = player

	elseif is_passenger == true and passenger_number == 2 then
		if not entity.passenger2_attach_at then
			entity.passenger2_attach_at = {x=0, y=0, z=0}
		end
		if not entity.passenger2_eye_offset then
			entity.passenger2_eye_offset = {x=0, y=0, z=0}
		end

		attach_at = entity.passenger2_attach_at
		eye_offset = entity.passenger2_eye_offset

		entity.passenger2 = player
		lib_mount.passengers[entity.passenger2] = player

	elseif is_passenger == true and passenger_number == 3 then
		if not entity.passenger3_attach_at then
			entity.passenger3_attach_at = {x=0, y=0, z=0}
		end
		if not entity.passenger3_eye_offset then
			entity.passenger3_eye_offset = {x=0, y=0, z=0}
		end

		attach_at = entity.passenger3_attach_at
		eye_offset = entity.passenger3_eye_offset

		entity.passenger3 = player
		lib_mount.passengers[entity.passenger3] = player
	else
		if not entity.driver_attach_at then
			entity.driver_attach_at = {x=0, y=0, z=0}
		end
		if not entity.driver_eye_offset then
			entity.driver_eye_offset = {x=0, y=0, z=0}
		end
		attach_at = entity.driver_attach_at
		eye_offset = entity.driver_eye_offset
		entity.driver = player
	end

	force_detach(player)

	player:set_attach(entity.object, "", attach_at, entity.player_rotation)
	players.player_attached[player:get_player_name()] = true
	player:set_eye_offset(eye_offset, {x=0, y=0, z=0})
	minetest.after(0.2, function()
		players.set_animation(player, "sit", 30)
	end)
	player:set_look_horizontal(entity.object:get_yaw() - rot_view)
end

function lib_mount.detach(player, offset)
	force_detach(player)
	players.set_animation(player, "stand", 30)
	local pos = player:get_pos()
	pos = {x = pos.x + offset.x, y = pos.y + 0.2 + offset.y, z = pos.z + offset.z}
	minetest.after(0.1, function()
		player:set_pos(pos)
	end)
end

local aux_timer = 0

function lib_mount.drive(entity, dtime, is_mob, moving_anim, stand_anim, 
	jump_height, can_fly, can_go_down, can_go_up, enable_crash)
	-- Sanity checks
	local ent_def = minetest.registered_entities[entity._name]

	can_fly = can_fly or ent_def.can_fly
	can_go_down = can_go_down or ent_def.can_go_down
	can_go_up = can_go_up or ent_def.can_go_up
	enable_crash = enable_crash or ent_def.enable_crash

	if entity.driver and not entity.driver:get_attach() then entity.driver = nil end

	if entity.passenger and not entity.passenger:get_attach() then
		entity.passenger = nil
	end
	if entity.passenger2 and not entity.passenger2:get_attach() then
		entity.passenger2 = nil
	end
	if entity.passenger3 and not entity.passenger3:get_attach() then
		entity.passenger3 = nil
	end

	aux_timer = aux_timer + dtime

	if can_fly and can_fly == true then
		jump_height = 0
	end

	local rot_steer, rot_view = math.pi/2, 0
	if entity.player_rotation.y == 90 then
		rot_steer, rot_view = 0, math.pi/2
	end

	local acce_y = 0

	local velo = entity.object:get_velocity()
	entity.v = get_v(velo) * get_sign(entity.v)

	-- process controls
	if entity.driver then
		local ctrl = entity.driver:get_player_control()
		if ctrl.aux1 then
			if aux_timer >= 0.2 then
				entity.mouselook = not entity.mouselook
				aux_timer = 0
			end
		end
		if ctrl.up then
			if get_sign(entity.v) >= 0 then
				entity.v = entity.v + entity.accel/10
			else
				entity.v = entity.v + entity.braking/10
			end
		elseif ctrl.down then
			if entity.max_speed_reverse == 0 and entity.v == 0 then return end
			if get_sign(entity.v) < 0 then
				entity.v = entity.v - entity.accel/10
			else
				entity.v = entity.v - entity.braking/10
			end
		end
		if entity.mouselook then
			if ctrl.left then
				entity.object:set_yaw(entity.object:get_yaw()+get_sign(entity.v)*math.rad(1+dtime)*entity.turn_spd)
			elseif ctrl.right then
				entity.object:set_yaw(entity.object:get_yaw()-get_sign(entity.v)*math.rad(1+dtime)*entity.turn_spd)
			end
		else
			entity.object:set_yaw(entity.driver:get_look_horizontal() - rot_steer 
				+ 1.570796)
		end
		if ctrl.jump then
			if jump_height > 0 and velo.y == 0 then
				velo.y = velo.y + (jump_height * 3) + 1
				acce_y = acce_y + (acce_y * 3) + 1
			end
			if can_go_down and can_go_up and can_fly and can_fly == true then
				velo.y = velo.y + 1
				acce_y = acce_y + 1
			end
		end
		if ctrl.sneak then
			if can_go_down and can_go_up and can_fly and can_fly == true then
				velo.y = velo.y - 1
				acce_y = acce_y - 1
			end
		end
	end

	-- if not moving then set animation and return
	if entity.v == 0 and velo.x == 0 and velo.y == 0 and velo.z == 0 then
		if is_mob and mobs_redo == true then
			if stand_anim and stand_anim ~= nil then
				set_animation(entity, stand_anim)
			end
		end
		return
	end

	-- set animation
	if is_mob and mobs_redo == true then
		if moving_anim and moving_anim ~= nil then
			set_animation(entity, moving_anim)
		end
	end

	-- Stop!
	local s = get_sign(entity.v)
	entity.v = entity.v - 0.02 * s
	if s ~= get_sign(entity.v) then
		entity.object:set_velocity({x=0, y=0, z=0})
		entity.v = 0
		return
	end

	-- enforce speed limit forward and reverse
	local max_spd = entity.max_speed_reverse
	if get_sign(entity.v) >= 0 then
		max_spd = entity.max_speed_forward
	end
	if math.abs(entity.v) > max_spd then
		entity.v = entity.v - get_sign(entity.v)
	end

	-- Set position, velocity and acceleration
	local p = entity.object:get_pos()
	local new_velo = {x=0, y=0, z=0}
	local new_acce = {x=0, y=-9.8, z=0}

	p.y = p.y - 0.5
	local ni = node_is(p)
	local v = entity.v
	if ni == "air" then
		if can_fly == true then
			new_acce.y = 0
		end
	elseif ni == "liquid" then
		if entity.terrain_type == 2 or entity.terrain_type == 3 then
			new_acce.y = 0
			p.y = p.y + 1
			if node_is(p) == "liquid" then
				if velo.y >= 5 then
					velo.y = 5
				elseif velo.y < 0 then
					new_acce.y = 20
				else
					new_acce.y = 5
				end
			else
				if math.abs(velo.y) < 1 then
					local pos = entity.object:get_pos()
					pos.y = math.floor(pos.y) + 0.5
					entity.object:set_pos(pos)
					velo.y = 0
				end
			end
		else
			v = v*0.25
		end
	--elseif ni == "walkable" then
		--v = 0
		--new_acce.y = 1
	end

	new_velo = get_velocity(v, entity.object:get_yaw() - rot_view, velo.y)
	new_acce.y = new_acce.y + acce_y

	entity.object:set_velocity(new_velo)
	entity.object:set_acceleration(new_acce)

	-- CRASH!
	if enable_crash then
		local intensity = entity.v2 - v
		if intensity >= crash_threshold then
			if is_mob then
				entity.object:set_hp(entity.object:get_hp() - intensity)
			else
				if entity.driver then
					local drvr = entity.driver
					lib_mount.detach(drvr, {x=0, y=0, z=0})
					drvr:set_velocity(new_velo)
					drvr:set_hp(drvr:get_hp() - intensity)
				end

				if entity.passenger then
					local pass = entity.passenger
					lib_mount.detach(pass, {x=0, y=0, z=0})
					pass:set_velocity(new_velo)
					pass:set_hp(pass:get_hp() - intensity)
				end

				if entity.passenger2 then
					local pass = entity.passenger2
					lib_mount.detach(pass, {x=0, y=0, z=0})
					pass:set_velocity(new_velo)
					pass:set_hp(pass:get_hp() - intensity)
				end

				if entity.passenger3 then
					local pass = entity.passenger3
					lib_mount.detach(pass, {x=0, y=0, z=0})
					pass:set_velocity(new_velo)
					pass:set_hp(pass:get_hp() - intensity)
				end
				local pos = entity.object:get_pos()

				------------------
				-- Handle drops --
				------------------

				-- `entity.drop_on_destory` is table which stores all the items that will be dropped on destroy.
				-- It will drop one of those items, from `1` to the length, or the end of the table.

				local i = rand.az(1, #entity.drop_on_destroy)
				local j = rand.az(2, #entity.drop_on_destroy)

				minetest.add_item(pos, entity.drop_on_destroy[i])
				if i ~= j then
					minetest.add_item(pos, entity.drop_on_destroy[j])
				end

				entity.removed = true
				-- delay remove to ensure player is detached
				minetest.after(0.1, function()
					entity.object:remove()
				end)
			end
		end
	end

	entity.v2 = v
end

function lib_mount.on_rightclick(self, clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	-- if there is already a driver
	if self.driver then
		-- if clicker is driver detach passengers and driver
		if clicker == self.driver then
			if self.passenger then
				lib_mount.detach(self.passenger, self.offset)
			end

			if self.passenger2 then
				lib_mount.detach(self.passenger2, self.offset)
			end

			if self.passenger3 then
				lib_mount.detach(self.passenger3, self.offset)
			end
			-- detach driver
			lib_mount.detach(self.driver, self.offset)
		-- if clicker is not the driver
		else
			-- if clicker is passenger
			-- detach passengers
			if clicker == self.passenger then
				lib_mount.detach(self.passenger, self.offset)

			elseif clicker == self.passenger2 then
				lib_mount.detach(self.passenger2, self.offset)

			elseif clicker == self.passenger3 then
				lib_mount.detach(self.passenger3, self.offset)
			-- if clicker is not passenger
			else
				-- attach passengers if possible
				if lib_mount.passengers[self.passenger] == self.passenger 
					and self.number_of_passengers >= 1 then
					lib_mount.attach(self, clicker, true, 1)
				end
				if lib_mount.passengers[self.passenger2] == self.passenger2 
					and self.number_of_passengers >= 2 then
					lib_mount.attach(self, clicker, true, 2)
				end
				if lib_mount.passengers[self.passenger3] == self.passenger3 
					and self.number_of_passengers >= 3 then
					lib_mount.attach(self, clicker, true, 3)
				end
			end
		end
	-- if there is no driver
	else
		-- attach driver
		if self.owner == clicker:get_player_name() then
			lib_mount.attach(self, clicker, false, 0)
		end
	end
end

function lib_mount.on_activate(self, staticdata, dtime_s)
	self.object:set_armor_groups({immortal = 1})
	local data = minetest.deserialize(staticdata)
	if data then
		for key, stat in pairs(data) do
			if key == "owner" then print(stat) end
			self[key] = stat
		end
	end
	print("owner: ", self.owner)
	self.v2 = self.v
end

function lib_mount.get_staticdata(self)
	local data = {}
	for key, stat in pairs(self) do
		local typ3 = type(stat)
		if typ3 ~= 'function' and typ3 ~= 'nil' and typ3 ~= 'userdata' then
			data[key] = self[key]
		end
	end
	return core.serialize(data)
end

function lib_mount.on_punch(self, puncher)
	if not puncher or not puncher:is_player() or self.removed or self.driver then
		return
	end
	local punchername = puncher:get_player_name()
	if self.owner == punchername or minetest.get_player_privs(punchername).protection_bypass then
		self.removed = true
		-- delay remove to ensure player is detached
		minetest.after(0.1, function()
		self.object:remove()
	end)
		puncher:get_inventory():add_item("main", self.name)
	end
end

function lib_mount.on_step(self, dtime)
	lib_mount.drive(self, dtime, false, nil, nil, 0)
end

function lib_mount.register_entity(name, def)
	minetest.register_entity(name, {
		infotext = def.infotext, 
		physical = true,
		collisionbox = def.collisionbox,
		visual = def.visual or "mesh",
		mesh = def.mesh,
		visual_size = def.visual_size,
		textures = def.textures,
		stepheight = def.stepheight,

		terrain_type = def.terrain_type,
		can_fly = def.can_fly,
		can_go_down = def.can_go_down,
		can_go_up = def.can_go_up,
		player_rotation = def.player_rotation,
		driver_attach_at = def.driver_attach_at,
		driver_eye_offset = def.driver_eye_offset,
		driver_detach_pos_offset = def.driver_detach_pos_offset,
		number_of_passengers = def.number_of_passengers,
		passenger_attach_at = def.passenger_attach_at,
		passenger_eye_offset = def.passenger_eye_offset,
		passenger_detach_pos_offset = def.passenger_detach_pos_offset,
		passenger2_attach_at = def.passenger2_attach_at,
		passenger2_eye_offset = def.passenger2_eye_offset,
		passenger2_detach_pos_offset = def.passenger2_detach_pos_offset,
		passenger3_attach_at = def.passenger3_attach_at,
		passenger3_eye_offset = def.passenger3_eye_offset,
		passenger3_detach_pos_offset = def.passenger3_detach_pos_offset,
		enable_crash = def.enable_crash or true,
		tiles = def.tiles,
		max_speed_forward = def.max_speed_forward,
		max_speed_reverse = def.max_speed_reverse,
		accel = def.accel,
		braking = def.braking,
		turn_spd = def.turn_speed,
		drop_on_destroy = def.drop_on_destroy or {},
		driver = nil,
		passenge = nil,
		v = 0,
		v2 = 0,
		mouselook = false,
		removed = false,
		offset = {x=0, y=0, z=0},
		owner = "",
		on_rightclick = def.on_rightclick or lib_mount.on_rightclick,
		on_activate = def.on_activate or lib_mount.on_activate,
		get_staticdata = def.get_staticdata or lib_mount.get_staticdata,
		on_punch = def.on_punch or lib_mount.on_punch,
		on_step = def.on_step or lib_mount.on_step,
		_name = name
	})
end

function lib_mount.on_place(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" then
		return
	end
	local def = itemstack:get_definition()
	local name = itemstack:get_name()

	local ent
	if minetest.get_item_group(minetest.get_node(pointed_thing.under).name, "liquid") == 0 then
		if def.terrain_type == 0 or def.terrain_type == 1 or def.terrain_type == 3 then
			pointed_thing.above.y = pointed_thing.above.y + def.onplace_position_adj
			ent = minetest.add_entity(pointed_thing.above, name)
		else
			return
		end
	else
		if def.terrain_type == 2 or def.terrain_type == 3 then
			pointed_thing.under.y = pointed_thing.under.y + 0.5
			ent = minetest.add_entity(pointed_thing.under, name)
		else
			return
		end
	end
	if ent:get_luaentity().player_rotation.y == 90 then
		ent:set_yaw(placer:get_look_horizontal())
	else
		ent:set_yaw(placer:get_look_horizontal() - math.pi/2)
	end
	ent:get_luaentity().owner = placer:get_player_name()
	itemstack:take_item()
	return itemstack
end

function lib_mount.register_craftitem(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_craftitem(name, {
		description = def.description or txt,
		inventory_image = def.inventory_image or txt .. "_inventory.png",
		wield_image = def.wield_image or txt .. "_wield.png",
		wield_scale = def.wield_scale,
		groups = def.groups,
		liquids_pointable = def.terrain_type == 2 or def.terrain_type == 3,
		on_place = def.on_place or lib_mount.on_place,
		on_secondary_use = def.on_secondary_use,
		on_drop = def.on_drop,
		on_use = def.on_use,
		after_use = def.after_use,
		terrain_type = def.terrain_type,
		onplace_position_adj = def.onplace_position_adj
	})

	if def.recipe then
		minetest.register_craft({
			output = name,
			recipe = def.recipe
		})
	end

	if def.burntime then
		minetest.register_craft({
			type = "fuel",
			recipe = name,
			burntime = def.burntime
		})
	end
end

function lib_mount.register_mount(name, def)
	lib_mount.register_entity(name, def.entity)

	if def.craftitem then
		def.craftitem.terrain_type = def.entity.terrain_type
		lib_mount.register_craftitem(name, def.craftitem)
	end
end
