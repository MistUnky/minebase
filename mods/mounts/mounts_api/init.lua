mounts = {
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

local function get_v(v)
	return math.sqrt(v.x ^ 2 + v.z ^ 2)
end

-------------------------------------------------------------------------------

minetest.register_on_leaveplayer(function(player)
	mounts.force_detach(player)
end)

minetest.register_on_shutdown(function()
	local players = minetest.get_connected_players()
	for i = 1, #players do
		mounts.force_detach(players[i])
	end
end)

minetest.register_on_dieplayer(function(player)
	mounts.force_detach(player)
	return true
end)

-------------------------------------------------------------------------------

function mounts.get_velocity(v, yaw, y)
	local x = -math.sin(yaw) * v
	local z =  math.cos(yaw) * v
	return {x = x, y = y, z = z}
end

function mounts.attached(entity, player)
	for i, passenger in pairs(entity._passengers) do
		if player == passenger then
			return i
		end
	end 
	return nil
end

function mounts.force_detach(player)
	local attached_to = player:get_attach()
	if attached_to then
		local entity = attached_to:get_luaentity()
		local seat = mounts.attached(entity, player)
		if seat then
			entity._passengers[seat] = nil
			mounts.passengers[player] = nil
		end
		player:set_detach()
		players.player_attached[player:get_player_name()] = false
		player:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
		players.set_animation(player, "stand", 30)
	end
end

local function after_attach(player)
	players.set_animation(player, "sit", 30)
end

function mounts.attach(entity, player, seat)
	seat = seat or #entity._passengers + 1
	if not entity._player_rotation then
		entity._player_rotation = {x=0, y=0, z=0}
	end

	local rot_view = 0
	if entity._player_rotation.y == 90 then
		rot_view = math.pi / 2
	end

	mounts.force_detach(player)

	if not entity._attach_at[seat] then
		entity._attach_at[seat] = {x=0, y=0, z=0}
	end
	if not entity._eye_offset[seat] then
		entity._eye_offset[seat] = {x=0, y=0, z=0}
	end

	entity._passengers[seat] = player
	mounts.passengers[player] = true

	player:set_attach(entity.object, "", entity._attach_at[seat], 
		entity._player_rotation)
	players.player_attached[player:get_player_name()] = true
	player:set_eye_offset(entity._eye_offset[seat], {x=0, y=0, z=0})
	minetest.after(0.2, after_attach, player)
	player:set_look_horizontal(entity.object:get_yaw() - rot_view)
end

local function after_detach(player, pos)
	player:set_pos(pos)
end

local v000 = {x = 0, y = 0, z = 0}
function mounts.detach(player, offset)
	offset = offset or v000
	mounts.force_detach(player)
	local pos = player:get_pos()
	pos = {x = pos.x + offset.x, y = pos.y + 0.2 + offset.y, z = pos.z + offset.z}
	minetest.after(0.1, after_detach, player, pos)
end

function mounts.detach_all(entity)
	for seat, passenger in pairs(entity._passengers) do
		mounts.detach(passenger, entity._detach_pos_offset[seat])
	end
end

local aux_timer = 0

local function after_crash(entity)
	entity.object:remove()
end

function mounts.drive(entity, dtime, is_mob, moving_anim, stand_anim, 
	jump_height, can_fly, can_go_down, can_go_up, enable_crash)
	-- Sanity checks
	local ent_def = minetest.registered_entities[entity._name]

	can_fly = can_fly or ent_def._can_fly
	can_go_down = can_go_down or ent_def._can_go_down
	can_go_up = can_go_up or ent_def._can_go_up
	enable_crash = enable_crash or ent_def._enable_crash

	for seat, passenger in pairs(entity._passengers) do
		if not passenger:get_attach() then
			entity._passengers[seat] = nil
		end
	end

	aux_timer = aux_timer + dtime

	if can_fly then
		jump_height = 0
	end

	local rot_steer, rot_view = math.pi / 2, 0
	if entity._player_rotation.y == 90 then
		rot_steer, rot_view = 0, math.pi / 2
	end

	local acce_y = 0

	local velo = entity.object:get_velocity()
	entity._v = get_v(velo) * get_sign(entity._v)

	-- process controls
	if entity._passengers[1] then
		local ctrl = entity._passengers[1]:get_player_control()
		if ctrl.aux1 then
			if aux_timer >= 0.2 then
				entity._mouselook = not entity._mouselook
				aux_timer = 0
			end
		end
		if ctrl.up then
			if get_sign(entity._v) >= 0 then
				entity._v = entity._v + entity._accel / 10
			else
				entity._v = entity._v + entity._braking / 10
			end
		elseif ctrl.down then
			if entity._max_speed_reverse == 0 and entity._v == 0 then return end
			if get_sign(entity._v) < 0 then
				entity._v = entity._v - entity._accel / 10
			else
				entity._v = entity._v - entity._braking / 10
			end
		end
		if entity._mouselook then
			if ctrl.left then
				entity.object:set_yaw(entity.object:get_yaw() + get_sign(entity._v)
					* math.rad(1 + dtime) * entity._turn_spd)
			elseif ctrl.right then
				entity.object:set_yaw(entity.object:get_yaw() - get_sign(entity._v)
					* math.rad(1 + dtime) * entity._turn_spd)
			end
		else
			entity.object:set_yaw(entity._passengers[1]:get_look_horizontal() 
				- rot_steer + 1.570796)
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
	if entity._v == 0 and velo.x == 0 and velo.y == 0 and velo.z == 0 then
		if is_mob then
			if stand_anim and stand_anim ~= nil then
				set_animation(entity, stand_anim)
			end
		end
		return
	end

	-- set animation
	if is_mob then
		if moving_anim and moving_anim ~= nil then
			set_animation(entity, moving_anim)
		end
	end

	-- Stop!
	local s = get_sign(entity._v)
	entity._v = entity._v - 0.02 * s
	if s ~= get_sign(entity._v) then
		entity.object:set_velocity({x = 0, y = 0, z = 0})
		entity._v = 0
		return
	end

	-- enforce speed limit forward and reverse
	local max_spd = entity._max_speed_reverse
	if get_sign(entity._v) >= 0 then
		max_spd = entity._max_speed_forward
	end
	if math.abs(entity._v) > max_spd then
		entity._v = entity._v - get_sign(entity._v)
	end

	-- Set position, velocity and acceleration
	local p = entity.object:get_pos()
	local new_velo = {x = 0, y = 0, z = 0}
	local new_acce = {x = 0, y = -9.8, z = 0}

	p.y = p.y - 0.5
	local ni = node_is(p)
	local v = entity._v
	if ni == "air" then
		if can_fly == true then
			new_acce.y = 0
		end
	elseif ni == "liquid" then
		if entity._terrain_type == 2 or entity._terrain_type == 3 then
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

	new_velo = mounts.get_velocity(v, entity.object:get_yaw() - rot_view, 
		velo.y)
	new_acce.y = new_acce.y + acce_y

	entity.object:set_velocity(new_velo)
	entity.object:set_acceleration(new_acce)

	-- CRASH!
	if enable_crash then
		local intensity = entity._v2 - v
		if intensity >= crash_threshold then
			if is_mob then
				entity.object:set_hp(entity.object:get_hp() - intensity)
			else
				for seat, passenger in pairs(entity._passengers) do
					mounts.detach(passenger, entity._detach_pos_offset[seat])
					passenger:set_velocity(new_velo)
					passenger:set_hp(passenger:get_hp() - intensity)
				end

				local pos = entity.object:get_pos()

				------------------
				-- Handle drops --
				------------------

				--[[ `entity.drop_on_destory` is table which stores all the items that 
					will be dropped on destroy.
					It will drop one of those items, from `1` to the length, or the end of 
					the table.
				]]

				local i = rand.az(1, #entity._drop_on_destroy)
				local j = rand.az(2, #entity._drop_on_destroy)

				minetest.add_item(pos, entity._drop_on_destroy[i])
				if i ~= j then
					minetest.add_item(pos, entity._drop_on_destroy[j])
				end

				entity._removed = true
				-- delay remove to ensure player is detached
				minetest.after(0.1, after_crash, entity)
			end
		end
	end

	entity._v2 = v
end

function mounts.on_rightclick(entity, clicker)
	if not clicker or not clicker:is_player() then
		return
	end

	local seat = mounts.attached(entity, clicker)
	if seat then
		mounts.detach(clicker, entity._detach_pos_offset[seat])
	else
		if entity._owner == clicker:get_player_name() then
			mounts.attach(entity, clicker, 1)
		elseif entity._passengers[1] and t4b.count(entity._passengers) 
			< entity._max_passengers then
			mounts.attach(entity, clicker)
		end
	end
end

function mounts.on_activate(entity, staticdata, dtime_s)
	entity.object:set_armor_groups({immortal = 1})
	local data = minetest.deserialize(staticdata)
	if data then
		for key, stat in pairs(data) do
			if key == "owner" then print(stat) end
			entity[key] = stat
		end
	end
	if not entity._passengers then
		entity._passengers = {}
	end
	print("owner: ", entity._owner)
	entity._v2 = entity._v
end

function mounts.get_staticdata(entity)
	local data = {}
	for key, stat in pairs(entity) do
		local typ3 = type(stat)
		if typ3 ~= 'function' and typ3 ~= 'nil' and typ3 ~= 'userdata' then
			data[key] = entity[key]
		end
	end
	return core.serialize(data)
end

local function after_punch(entity)
	entity.object:remove()
end

function mounts.on_punch(entity, puncher)
	if not puncher or not puncher:is_player() or entity._removed 
		or entity._passengers[1] then
		return
	end
	local punchername = puncher:get_player_name()
	if entity._owner == punchername or minetest.get_player_privs(punchername)
		.protection_bypass then
		entity._removed = true
		-- delay remove to ensure player is detached
		minetest.after(0.1, after_punch, entity)
		puncher:get_inventory():add_item("main", entity._name)
	end
end

function mounts.on_step(entity, dtime)
	mounts.drive(entity, dtime, false, nil, nil, 0)
end

function mounts.register_entity(name, def)
	minetest.register_entity(name, {
		infotext = def.infotext, 
		physical = true,
		collisionbox = def.collisionbox,
		visual = def.visual or "mesh",
		mesh = def.mesh,
		visual_size = def.visual_size,
		textures = def.textures,
		stepheight = def.stepheight,
		on_rightclick = def.on_rightclick or mounts.on_rightclick,
		on_activate = def.on_activate or mounts.on_activate,
		get_staticdata = def.get_staticdata or mounts.get_staticdata,
		on_punch = def.on_punch or mounts.on_punch,
		on_step = def.on_step or mounts.on_step,

		_terrain_type = def.terrain_type,
		_can_fly = def.can_fly,
		_can_go_down = def.can_go_down,
		_can_go_up = def.can_go_up,
		_player_rotation = def.player_rotation,
		_attach_at = def.attach_at or {{x = 0, y = 0, z = 0}},
		_eye_offset = def.eye_offset or {{x = 0, y = 0, z = 0}},
		_pos_offset = def.pos_offset or {{x = 0, y = 0, z = 0}},
		_detach_pos_offset = def.detach_pos_offset or {{x = 0, y = 0, z = 0}},
		_max_passengers = def.max_passengers or 1,
		_enable_crash = def.enable_crash or true,
		_max_speed_forward = def.max_speed_forward,
		_max_speed_reverse = def.max_speed_reverse,
		_accel = def.accel,
		_braking = def.braking,
		_turn_speed = def.turn_speed,
		_drop_on_destroy = def.drop_on_destroy or {},
		_v = 0,
		_v2 = 0,
		_mouselook = false,
		_removed = false,
		_owner = "",
		_name = name
	})
end

function mounts.on_place(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" then
		return
	end
	local def = itemstack:get_definition()
	local name = itemstack:get_name()

	local ent
	if minetest.get_item_group(minetest.get_node(pointed_thing.under).name, "liquid") == 0 then
		if def._terrain_type == 0 or def._terrain_type == 1 or def._terrain_type == 3 then
			pointed_thing.above.y = pointed_thing.above.y + def._on_place_position_adj
			ent = minetest.add_entity(pointed_thing.above, name)
		else
			return
		end
	else
		if def._terrain_type == 2 or def._terrain_type == 3 then
			pointed_thing.under.y = pointed_thing.under.y + 0.5
			ent = minetest.add_entity(pointed_thing.under, name)
		else
			return
		end
	end
	if ent:get_luaentity()._player_rotation.y == 90 then
		ent:set_yaw(placer:get_look_horizontal())
	else
		ent:set_yaw(placer:get_look_horizontal() - math.pi / 2)
	end
	ent:get_luaentity()._owner = placer:get_player_name()
	itemstack:take_item()
	return itemstack
end

function mounts.register_craftitem(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_craftitem(name, {
		description = def.description or txt,
		inventory_image = def.inventory_image or txt .. "_inventory.png",
		wield_image = def.wield_image or txt .. "_wield.png",
		wield_scale = def.wield_scale,
		groups = def.groups,
		liquids_pointable = def.terrain_type == 2 or def.terrain_type == 3,
		on_place = def.on_place or mounts.on_place,
		on_secondary_use = def.on_secondary_use,
		on_drop = def.on_drop,
		on_use = def.on_use,
		after_use = def.after_use,
		_terrain_type = def.terrain_type,
		_on_place_position_adj = def.on_place_position_adj
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

function mounts.register_mount(name, def)
	mounts.register_entity(name, def.entity)

	if def.craftitem then
		def.craftitem.terrain_type = def.entity.terrain_type
		mounts.register_craftitem(name, def.craftitem)
	end
end
