-- screwdrivers/init.lua

screwdrivers = {ROTATE_FACE = 1, ROTATE_AXIS = 2}

-- Load support for Minebase translation.
local S = minetest.get_translator("screwdrivers")

-- For attached wallmounted nodes: returns true if rotation is valid
-- simplified version of minetest:builtin/game/falling.lua#L148.
function screwdrivers.check_attached_node(pos, rotation)
	local d = minetest.wallmounted_to_dir(rotation)
	local p2 = vector.add(pos, d)
	local n = minetest.get_node(p2).name
	local def2 = minetest.registered_nodes[n]
	if def2 and not def2.walkable then
		return false
	end
	return true
end

screwdrivers.rotate = {}

local facedir_tbl = {
	[screwdrivers.ROTATE_FACE] = {
		[0] = 1, [1] = 2, [2] = 3, [3] = 0,
		[4] = 5, [5] = 6, [6] = 7, [7] = 4,
		[8] = 9, [9] = 10, [10] = 11, [11] = 8,
		[12] = 13, [13] = 14, [14] = 15, [15] = 12,
		[16] = 17, [17] = 18, [18] = 19, [19] = 16,
		[20] = 21, [21] = 22, [22] = 23, [23] = 20,
	},
	[screwdrivers.ROTATE_AXIS] = {
		[0] = 4, [1] = 4, [2] = 4, [3] = 4,
		[4] = 8, [5] = 8, [6] = 8, [7] = 8,
		[8] = 12, [9] = 12, [10] = 12, [11] = 12,
		[12] = 16, [13] = 16, [14] = 16, [15] = 16,
		[16] = 20, [17] = 20, [18] = 20, [19] = 20,
		[20] = 0, [21] = 0, [22] = 0, [23] = 0,
	},
}

function screwdrivers.rotate.facedir(pos, node, mode)
	local rotation = node.param2 % 32 -- get first 5 bits
	local other = node.param2 - rotation
	rotation = facedir_tbl[mode][rotation] or 0
	return rotation + other
end

screwdrivers.rotate.colorfacedir = screwdrivers.rotate.facedir

local wallmounted_tbl = {
	[screwdrivers.ROTATE_FACE] = {[2] = 5, [3] = 4, [4] = 2, [5] = 3, [1] = 0, [0] = 1},
	[screwdrivers.ROTATE_AXIS] = {[2] = 5, [3] = 4, [4] = 2, [5] = 1, [1] = 0, [0] = 3}
}

function screwdrivers.rotate.wallmounted(pos, node, mode)
	local rotation = node.param2 % 8 -- get first 3 bits
	local other = node.param2 - rotation
	rotation = wallmounted_tbl[mode][rotation] or 0
	if minetest.get_item_group(node.name, "attached_node") ~= 0 then
		-- find an acceptable orientation
		for i = 1, 5 do
			if not screwdrivers.check_attached_node(pos, rotation) then
				rotation = wallmounted_tbl[mode][rotation] or 0
			else
				break
			end
		end
	end
	return rotation + other
end

screwdrivers.rotate.colorwallmounted = screwdrivers.rotate.wallmounted

-- Handles rotation
function screwdrivers.handler(itemstack, user, pointed_thing, mode, uses)
	if pointed_thing.type ~= "node" then
		return
	end

	local pos = pointed_thing.under
	local player_name = user and user:get_player_name() or ""

	if minetest.is_protected(pos, player_name) then
		minetest.record_protection_violation(pos, player_name)
		return
	end

	local node = minetest.get_node(pos)
	local ndef = minetest.registered_nodes[node.name]
	if not ndef then
		return itemstack
	end
	-- can we rotate this paramtype2?
	local fn = screwdrivers.rotate[ndef.paramtype2]
	if not fn and not ndef.on_rotate then
		return itemstack
	end

	local should_rotate = true
	local new_param2
	if fn then
		new_param2 = fn(pos, node, mode)
	else
		new_param2 = node.param2
	end

	-- Node provides a handler, so let the handler decide instead if the node can be rotated
	if ndef.on_rotate then
		-- Copy pos and node because callback can modify it
		local result = ndef.on_rotate(vector.new(pos),
				{name = node.name, param1 = node.param1, param2 = node.param2},
				user, mode, new_param2)
		if result == false then -- Disallow rotation
			return itemstack
		elseif result == true then
			should_rotate = false
		end
	elseif ndef.on_rotate == false then
		return itemstack
	elseif ndef.can_dig and not ndef.can_dig(pos, user) then
		return itemstack
	end

	if should_rotate and new_param2 ~= node.param2 then
		node.param2 = new_param2
		minetest.swap_node(pos, node)
		minetest.check_for_falling(pos)
	end

	if not minetest.is_creative_enabled(player_name) then
		itemstack:add_wear(65535 / ((uses or 200) - 1))
	end

	return itemstack
end

--[[
local radians = 6.283185
local new = {
	w = {[0] = 7, 4, 5, 6,
		21, 22, 23, 20,
		 3, 0, 1, 2
	}
}
function screwdrivers.abc(itemstack, user, pointed_thing, button)
	if pointed_thing.type ~= "node" then
		return
	end

	local pos = pointed_thing.under
	local node = minetest.get_node(pos)
	local new_param2 
	local yaw = user:get_look_horizontal()

		--index 0 bis 24
	if button == 1 then
		local rotation = node.param2 % 32
		print(rotation)
		local dir = yaw >= 0 and yaw < 3.141593 and "w" or "e"
		if dir == "w" then
			new_param2 = node.param2 - rotation + facedir_tbl[1][new.w[rotation] or 0]
		else
			new_param2 = node.param2 - rotation + 11
			--TODO
		end
	else
		local dir = yaw >= 1.570796 and yaw < 4.712389 and "s" or "n"
		if dir == "s" then
		else
		end
	end
	print(yaw, dir)
	node.param2 = new_param2
	minetest.swap_node(pos, node)
end
--]]

function screwdrivers.register_screwdriver(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_tool(name, {
		description = def.description, 
		inventory_image = def.inventory_image or txt .. ".png",
		wield_image = def.wield_image or txt .. ".png",
		groups = def.groups or {tool = 1},
		on_use = def.on_use,
		on_place = def.on_place,
		on_secondary_use = def.on_secondary_use,
		on_drop = def.on_drop,
		after_use = def.after_use
	})

	if def.recipe then
		minetest.register_craft({
			output = name,
			recipe = def.recipe
		})
	end
end



