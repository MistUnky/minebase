-- doors_api/init.lua

-- our API object
doors = {}

doors.registered_doors = {}
doors.registered_trapdoors = {}

-- Load support for Minebase translation.
local S = minetest.get_translator("doors_api")


local function replace_old_owner_information(pos)
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("doors_owner")
	if owner and owner ~= "" then
		meta:set_string("owner", owner)
		meta:set_string("doors_owner", "")
	end
end

local doors_get = {}
function doors_get.door_open(self, player)
	if self:state() then
		return false
	end
	return doors.door_toggle(self.pos, nil, player)
end

function doors_get.door_close(self, player)
	if not self:state() then
		return false
	end
	return doors.door_toggle(self.pos, nil, player)
end

function doors_get.door_toggle(self, player)
	return doors.door_toggle(self.pos, nil, player)
end

function doors_get.door_state(self)
	local state = minetest.get_meta(self.pos):get_int("state")
	return state %2 == 1
end

function doors_get.trapdoor_open(self, player)
	if self:state() then
		return false
	end
	return doors.trapdoor_toggle(self.pos, nil, player)
end

function doors_get.trapdoor_close(self, player)
	if not self:state() then
		return false
	end
	return doors.trapdoor_toggle(self.pos, nil, player)
end

function doors_get.trapdoor_toggle(self, player)
	return doors.trapdoor_toggle(self.pos, nil, player)
end

function doors_get.trapdoor_state(self)
	return minetest.get_node(self.pos).name:sub(-5) == "_open"
end

-- returns an object to a door object or nil
function doors.get(pos)
	local node_name = minetest.get_node(pos).name
	if doors.registered_doors[node_name] then
		-- A normal upright door
		return {
			pos = pos,
			open = doors_get.door_open,
			close = doors_get.door_close,
			toggle = doors_get.door_toggle,
			state = doors_get.door_state 
		}
	elseif doors.registered_trapdoors[node_name] then
		-- A trapdoor
		return {
			pos = pos,
			open = doors_get.trapdoor_open,
			close = doors_get.trapdoor_close,
			toggle = doors_get.trapdoor_toggle,
			state = doors_get.trapdoor_state
		}
	else
		return nil
	end
end

-- this hidden node is placed on top of the bottom, and prevents
-- nodes from being placed in the top half of the door.
minetest.register_node("doors_api:hidden", {
	description = S("Hidden Door Segment"),
	inventory_image = "doors_api_hidden_segment.png",
	wield_image = "doors_api_hidden_segment.png",
	drawtype = "airlike",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	-- has to be walkable for falling nodes to stop falling.
	walkable = true,
	pointable = false,
	diggable = false,
	buildable_to = false,
	floodable = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
	on_blast = function() end,
	-- 1px block inside door hinge near node top
	collision_box = {
		type = "fixed",
		fixed = {-15/32, 13/32, -15/32, -13/32, 1/2, -13/32},
	},
})

-- table used to aid door opening/closing
local transform = {
	{
		{v = "_a", param2 = 3},
		{v = "_a", param2 = 0},
		{v = "_a", param2 = 1},
		{v = "_a", param2 = 2},
	},
	{
		{v = "_c", param2 = 1},
		{v = "_c", param2 = 2},
		{v = "_c", param2 = 3},
		{v = "_c", param2 = 0},
	},
	{
		{v = "_b", param2 = 1},
		{v = "_b", param2 = 2},
		{v = "_b", param2 = 3},
		{v = "_b", param2 = 0},
	},
	{
		{v = "_d", param2 = 3},
		{v = "_d", param2 = 0},
		{v = "_d", param2 = 1},
		{v = "_d", param2 = 2},
	},
}

function doors.door_toggle(pos, node, clicker)
	local meta = minetest.get_meta(pos)
	node = node or minetest.get_node(pos)
	local def = minetest.registered_nodes[node.name]
	local name = def._door.name

	local state = meta:get_string("state")
	if state == "" then
		-- fix up lvm-placed right-hinged doors, default closed
		if node.name:sub(-2) == "_b" then
			state = 2
		else
			state = 0
		end
	else
		state = tonumber(state)
	end

	replace_old_owner_information(pos)

	if clicker and not permissions.can_interact_with_node(clicker, pos) then
		return false
	end

	-- until Lua-5.2 we have no bitwise operators :(
	if state % 2 == 1 then
		state = state - 1
	else
		state = state + 1
	end

	local dir = node.param2

	-- It's possible param2 is messed up, so, validate before using
	-- the input data. This indicates something may have rotated
	-- the door, even though that is not supported.
	if not transform[state + 1] or not transform[state + 1][dir + 1] then
		return false
	end

	if state % 2 == 0 then
		minetest.sound_play(def._door.sounds[1],
			{pos = pos, gain = 0.3, max_hear_distance = 10}, true)
	else
		minetest.sound_play(def._door.sounds[2],
			{pos = pos, gain = 0.3, max_hear_distance = 10}, true)
	end

	minetest.swap_node(pos, {
		name = name .. transform[state + 1][dir+1].v,
		param2 = transform[state + 1][dir+1].param2
	})
	meta:set_int("state", state)

	return true
end

local function on_place_node(place_to, newnode, placer, oldnode, itemstack, 
	pointed_thing)
	-- Run script hook
	for _, callback in ipairs(minetest.registered_on_placenodes) do
		-- Deepcopy pos, node and pointed_thing because callback can modify them
		local place_to_copy = {x = place_to.x, y = place_to.y, z = place_to.z}
		local newnode_copy =
			{name = newnode.name, param1 = newnode.param1, param2 = newnode.param2}
		local oldnode_copy =
			{name = oldnode.name, param1 = oldnode.param1, param2 = oldnode.param2}
		local pointed_thing_copy = {
			type  = pointed_thing.type,
			above = vector.new(pointed_thing.above),
			under = vector.new(pointed_thing.under),
			ref   = pointed_thing.ref,
		}
		callback(place_to_copy, newnode_copy, placer, oldnode_copy, itemstack, 
			pointed_thing_copy)
	end
end

local function can_dig_door(pos, digger)
	replace_old_owner_information(pos)
	return permissions.can_interact_with_node(digger, pos)
end

local ref = {
	{x = -1, y = 0, z = 0},
	{x = 0, y = 0, z = 1},
	{x = 1, y = 0, z = 0},
	{x = 0, y = 0, z = -1}
}

function doors.on_place(itemstack, placer, pointed_thing)
	local pos

	if not pointed_thing.type == "node" then
		return itemstack
	end

	local node = minetest.get_node(pointed_thing.under)
	local pdef = minetest.registered_nodes[node.name]
	if pdef and pdef.on_rightclick and not (placer and placer:is_player() 
		and placer:get_player_control().sneak) then
		return pdef.on_rightclick(pointed_thing.under, node, placer, itemstack, 
			pointed_thing)
	end

	if pdef and pdef.buildable_to then
		pos = pointed_thing.under
	else
		pos = pointed_thing.above
		node = minetest.get_node(pos)
		pdef = minetest.registered_nodes[node.name]
		if not pdef or not pdef.buildable_to then
			return itemstack
		end
	end

	local above = {x = pos.x, y = pos.y + 1, z = pos.z}
	local top_node = minetest.get_node_or_nil(above)
	local topdef = top_node and minetest.registered_nodes[top_node.name]

	if not topdef or not topdef.buildable_to then
		return itemstack
	end

	local pn = placer and placer:get_player_name() or ""
	if minetest.is_protected(pos, pn) or minetest.is_protected(above, pn) then
		return itemstack
	end

	local dir = placer and minetest.dir_to_facedir(placer:get_look_dir()) or 0
	local aside = {
		x = pos.x + ref[dir + 1].x,
		y = pos.y + ref[dir + 1].y,
		z = pos.z + ref[dir + 1].z,
	}

	local state = 0
	local def = itemstack:get_definition()
	if minetest.get_item_group(minetest.get_node(aside).name, "door") == 1 then
		state = state + 2
		minetest.set_node(pos, {name = def._name .. "_b", param2 = dir})
		minetest.set_node(above, {name = "doors_api:hidden", param2 = (dir + 3) % 4})
	else
		minetest.set_node(pos, {name = def._name .. "_a", param2 = dir})
		minetest.set_node(above, {name = "doors_api:hidden", param2 = dir})
	end

	local meta = minetest.get_meta(pos)
	meta:set_int("state", state)

	if def._protected then
		meta:set_string("owner", pn)
		meta:set_string("infotext", def.description .. "\n" .. S("Owned by @1", pn))
	end

	if not minetest.is_creative_enabled(pn) then
		itemstack:take_item()
	end

	minetest.sound_play(def._sounds.place, {pos = pos}, true)

	on_place_node(pos, minetest.get_node(pos), placer, node, itemstack, 
		pointed_thing)

	return itemstack
end

function doors.on_rightclick(pos, node, clicker, itemstack)
	doors.door_toggle(pos, node, clicker)
	return itemstack
end

function doors.after_dig_node(pos, node)
	minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
	minetest.check_for_falling({x = pos.x, y = pos.y + 1, z = pos.z})
end

function doors.on_rotate() 
	return false
end

function doors.protected_on_blast() 
end

function doors.on_key_use(pos, player)
	return doors.get(pos):toggle(player)
end

function doors.on_skeleton_key_use(pos, player, newsecret)
	replace_old_owner_information(pos)
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")
	local pname = player:get_player_name()

	-- verify placer is owner of lockable door
	if owner ~= pname then
		minetest.record_protection_violation(pos, pname)
		minetest.chat_send_player(pname, S("Owned by @1", pname))
		return nil
	end

	local secret = meta:get_string("key_lock_secret")
	if secret == "" then
		secret = newsecret
		meta:set_string("key_lock_secret", secret)
	end

	return secret, S("Owned by @1"), owner
end

function doors.on_blast(pos)
	minetest.remove_node(pos)
	-- hidden node doesn't get blasted away.
	minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
	return {name}
end

function doors.on_destruct(pos)
	return minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
end

function doors.register_craftitem(name, def)
	minetest.register_craftitem(name, {
		description = def.description,
		inventory_image = def.inventory_image,
		groups = table.copy(def.groups),
		on_place = doors.on_place,
		_sounds = def.sounds or sounds.get_defaults("tree_sounds:wood"),
		_name = name,
		_protected = def.protected
	})

	if def.recipe then
		minetest.register_craft({
			output = name,
			recipe = def.recipe,
		})
	end
end

local function register_door(name, def)
	doors.registered_doors[name] = true
	minetest.register_node(name, {
		description = def.description,
		tiles = def.tiles,
		drawtype = "mesh",
		mesh = def.mesh,
		groups = def.groups,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		use_texture_alpha = "clip",
		walkable = true,
		is_ground_content = false,
		buildable_to = false,
		selection_box = def.selection_box or {
			type = "fixed", 
			fixed = {-1/2,-1/2,-1/2,1/2,3/2,-6/16}
		},
		collision_box = def.collision_box or {
			type = "fixed", 
			fixed = {-1/2,-1/2,-1/2,1/2,3/2,-6/16}
		},
		drop = def.drop,
		node_dig_prediction = def.node_dig_prediction,
		on_rightclick = def.on_rightclick or doors.on_rightclick,
		after_dig_node = def.after_dig_node or doors.after_dig_node,
		on_rotate = def.on_rotate or doors.on_rotate,
		on_destruct = def.on_destruct or doors.on_destruct,
		can_dig = def.can_dig_door,
		on_key_use = def.on_key_use,
		on_blast = def.on_blast,
		on_skeleton_key_use = def.on_skeleton_key_use,
		_sounds = def.sounds or sounds.get_defaults("tree_sounds:wood"),
		_door = def.door or {
			name = def.name,
			sounds = { 
				def.sound_close or "doors_api_wood_open", 
				def.sound_open or "doors_api_wood_close"
			},
		},
	})
end

function doors.register_door(name, def)
	doors.register_craftitem(name, def)	
	def.inventory_image = nil
	def.recipe = nil

	def.groups.not_in_creative_inventory = 1
	def.groups.door = 1

	def.drop = name
	def.name = name

	if def.protected then
		def.can_dig = can_dig_door
		def.on_blast = doors.protected_on_blast 
		def.on_key_use = doors.on_key_use
		def.on_skeleton_key_use = doors.on_skeleton_key_use 
		def.node_dig_prediction = ""
	else
		def.on_blast = doors.on_blast
	end

	def.mesh = "doors_api_door_a.obj"
	register_door(name .. "_a", def)

	def.mesh = "doors_api_door_b.obj"
	register_door(name .. "_b", def)

	def.mesh = "doors_api_door_a2.obj"
	register_door(name .. "_c", def)

	def.mesh = "doors_api_door_b2.obj"
	register_door(name .. "_d", def)
end

----trapdoor----

function doors.trapdoor_toggle(pos, node, clicker)
	node = node or minetest.get_node(pos)

	replace_old_owner_information(pos)

	if clicker and not permissions.can_interact_with_node(clicker, pos) then
		return false
	end

	local def = minetest.registered_nodes[node.name]

	if string.sub(node.name, -5) == "_open" then
		minetest.sound_play(def._sound_close,
			{pos = pos, gain = 0.3, max_hear_distance = 10}, true)
		minetest.swap_node(pos, {name = string.sub(node.name, 1,
			string.len(node.name) - 5), param1 = node.param1, param2 = node.param2})
	else
		minetest.sound_play(def._sound_open,
			{pos = pos, gain = 0.3, max_hear_distance = 10}, true)
		minetest.swap_node(pos, {name = node.name .. "_open",
			param1 = node.param1, param2 = node.param2})
	end
	return true
end

function doors.trapdoor_on_rightclick(pos, node, clicker, itemstack)
	doors.trapdoor_toggle(pos, node, clicker)
	return itemstack
end

function doors.trapdoor_after_place_node(pos, placer, itemstack)
	local pn = placer:get_player_name()
	local meta = minetest.get_meta(pos)
	local def = itemstack:get_definition()
	meta:set_string("owner", pn)
	meta:set_string("infotext", def.description .. "\n" .. S("Owned by @1", pn))

	return minetest.is_creative_enabled(pn)
end

function doors.trapdoor_on_blast(pos)
	minetest.remove_node(pos)
	return {name}
end

local function register_trapdoor(name, def)
	doors.registered_trapdoors[name] = true
	minetest.register_node(name, {
		description = def.description,
		tiles = def.tiles,
		inventory_image = def.inventory_image,
		wield_image = def.wield_image,
		drawtype = "nodebox",
		groups = def.groups,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		use_texture_alpha = "clip",
		walkable = true,
		is_ground_content = false,
		buildable_to = false,
		selection_box = def.selection_box,
		node_box = def.node_box,
		drop = def.drop,
		node_dig_prediction = def.node_dig_prediction,
		on_rightclick = def.on_rightclick or doors.trapdoor_on_rightclick,
		after_place_node = def.after_place_node,
		on_destruct = def.on_destruct or doors.on_destruct,
		can_dig = def.can_dig_door,
		on_key_use = def.on_key_use,
		on_blast = def.on_blast,
		on_skeleton_key_use = def.on_skeleton_key_use,
		_sounds = def.sounds or sounds.get_defaults("tree_sounds:wood"),
		_sound_close = def.sound_close or "doors_api_wood_open", 
		_sound_open = def.sound_open or "doors_api_wood_close"
	})
end

function doors.register_trapdoor(name, def)
	local name_closed = name
	local name_opened = name.."_open"

	if def.protected then
		def.can_dig = can_dig_door
		def.after_place_node = doors.trapdoor_after_place_node
		def.on_blast = doors.protected_on_blast
		def.on_key_use = doors.on_key_use 
		def.on_skeleton_key_use = doors.on_skeleton_key_use
		def.node_dig_prediction = ""
	else
		def.on_blast = doors.trapdoor_on_blast
	end

	local def_opened = table.copy(def)
	local def_closed = table.copy(def)

	def_closed.node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -6/16, 0.5}
	}
	def_closed.selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -6/16, 0.5}
	}
	def_closed.tiles = {
		def.tile_front,
		def.tile_front .. '^[transformFY',
		def.tile_side,
		def.tile_side,
		def.tile_side,
		def.tile_side
	}

	def_opened.node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 6/16, 0.5, 0.5, 0.5}
	}
	def_opened.selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 6/16, 0.5, 0.5, 0.5}
	}
	def_opened.tiles = {
		def.tile_side,
		def.tile_side .. '^[transform2',
		def.tile_side .. '^[transform3',
		def.tile_side .. '^[transform1',
		def.tile_front .. '^[transform46',
		def.tile_front .. '^[transform6'
	}

	def_opened.drop = name_closed
	def_opened.groups.not_in_creative_inventory = 1

	register_trapdoor(name_opened, def_opened)
	register_trapdoor(name_closed, def_closed)
end

