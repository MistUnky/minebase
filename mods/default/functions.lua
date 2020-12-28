--
-- Sounds
--

function default.node_sound_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "", gain = 1.0}
	table.dug = table.dug or
			{name = "default_dug_node", gain = 0.25}
	table.place = table.place or
			{name = "default_place_node_hard", gain = 1.0}
	return table
end

function default.node_sound_glass_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_glass_footstep", gain = 0.3}
	table.dig = table.dig or
			{name = "default_glass_footstep", gain = 0.5}
	table.dug = table.dug or
			{name = "default_break_glass", gain = 1.0}
	default.node_sound_defaults(table)
	return table
end

--
-- Optimized helper to put all items in an inventory into a drops list
--

function default.get_inventory_drops(pos, inventory, drops)
	local inv = minetest.get_meta(pos):get_inventory()
	local n = #drops
	for i = 1, inv:get_size(inventory) do
		local stack = inv:get_stack(inventory, i)
		if stack:get_count() > 0 then
			drops[n+1] = stack:to_table()
			n = n + 1
		end
	end
end


-- Wrapping the functions in ABM action is necessary to make overriding them possible


--
-- Fence registration helper
--

--
-- Convert default:dirt to something that fits the environment
--

minetest.register_abm({
	label = "Grass spread",
	nodenames = {"default:dirt"},
	neighbors = {
		"air",
		"group:grass",
		"group:dry_grass",
		"default:snow",
	},
	interval = 6,
	chance = 50,
	catch_up = false,
	action = function(pos, node)
		-- Check for darkness: night, shadow or under a light-blocking node
		-- Returns if ignore above
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		if (minetest.get_node_light(above) or 0) < 13 then
			return
		end

		-- Look for spreading dirt-type neighbours
		local p2 = minetest.find_node_near(pos, 1, "group:spreading_dirt_type")
		if p2 then
			local n3 = minetest.get_node(p2)
			minetest.set_node(pos, {name = n3.name})
			return
		end

		-- Else, any seeding nodes on top?
		local name = minetest.get_node(above).name
		-- Snow check is cheapest, so comes first
		if name == "default:snow" then
			minetest.set_node(pos, {name = "default:dirt_with_snow"})
		elseif minetest.get_item_group(name, "grass") ~= 0 then
			minetest.set_node(pos, {name = "default:dirt_with_grass"})
		elseif minetest.get_item_group(name, "dry_grass") ~= 0 then
			minetest.set_node(pos, {name = "default:dirt_with_dry_grass"})
		end
	end
})


--
-- Grass and dry grass removed in darkness
--

minetest.register_abm({
	label = "Grass covered",
	nodenames = {"group:spreading_dirt_type", "default:dry_dirt_with_dry_grass"},
	interval = 8,
	chance = 50,
	catch_up = false,
	action = function(pos, node)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore" and nodedef and not ((nodedef.sunlight_propagates or
				nodedef.paramtype == "light") and
				nodedef.liquidtype == "none") then
			if node.name == "default:dry_dirt_with_dry_grass" then
				minetest.set_node(pos, {name = "default:dry_dirt"})
			else
				minetest.set_node(pos, {name = "default:dirt"})
			end
		end
	end
})


--
-- Moss growth on cobble near water
--

local moss_correspondences = {
	["default:cobble"] = "default:mossycobble",
	["stairs:slab_cobble"] = "stairs:slab_mossycobble",
	["stairs:stair_cobble"] = "stairs:stair_mossycobble",
	["stairs:stair_inner_cobble"] = "stairs:stair_inner_mossycobble",
	["stairs:stair_outer_cobble"] = "stairs:stair_outer_mossycobble",
	["walls:cobble"] = "walls:mossycobble",
}
minetest.register_abm({
	label = "Moss growth",
	nodenames = {"default:cobble", "stairs:slab_cobble", "stairs:stair_cobble",
		"stairs:stair_inner_cobble", "stairs:stair_outer_cobble",
		"walls:cobble"},
	neighbors = {"group:water"},
	interval = 16,
	chance = 200,
	catch_up = false,
	action = function(pos, node)
		node.name = moss_correspondences[node.name]
		if node.name then
			minetest.set_node(pos, node)
		end
	end
})

--
-- Register a craft to copy the metadata of items
--

function default.register_craft_metadata_copy(ingredient, result)
	minetest.register_craft({
		type = "shapeless",
		output = result,
		recipe = {ingredient, result}
	})

	minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
		if itemstack:get_name() ~= result then
			return
		end

		local original
		local index
		for i = 1, #old_craft_grid do
			if old_craft_grid[i]:get_name() == result then
				original = old_craft_grid[i]
				index = i
			end
		end
		if not original then
			return
		end
		local copymeta = original:get_meta():to_table()
		itemstack:get_meta():from_table(copymeta)
		-- put the book with metadata back in the craft grid
		craft_inv:set_stack("craft", index, original)
	end)
end


--
-- NOTICE: This method is not an official part of the API yet.
-- This method may change in future.
--

function default.can_interact_with_node(player, pos)
	if player and player:is_player() then
		if minetest.check_player_privs(player, "protection_bypass") then
			return true
		end
	else
		return false
	end

	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")

	if not owner or owner == "" or owner == player:get_player_name() then
		return true
	end

	-- Is player wielding the right key?
	local item = player:get_wielded_item()
	if minetest.get_item_group(item:get_name(), "key") == 1 then
		local key_meta = item:get_meta()

		if key_meta:get_string("secret") == "" then
			local key_oldmeta = item:get_metadata()
			if key_oldmeta == "" or not minetest.parse_json(key_oldmeta) then
				return false
			end

			key_meta:set_string("secret", minetest.parse_json(key_oldmeta).secret)
			item:set_metadata("")
		end

		return meta:get_string("key_lock_secret") == key_meta:get_string("secret")
	end

	return false
end

