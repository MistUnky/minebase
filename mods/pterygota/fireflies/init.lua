-- firefly/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("fireflies")

pterygota.register_pterygota("fireflies:firefly", {
	visible = {
		description = S("Firefly"),
		length = 1.5,
		light_source = 6,
		on_timer = pterygota.on_timer_bright
	},
	hidden = {
		description = S("Hidden Firefly"),
		on_timer = pterygota.on_timer_dark,
		deco = {
			place_on = {
				"base_earth:dirt_with_grass",
				"base_earth:dirt_with_coniferous_litter",
				"base_earth:dirt_with_rainforest_litter",
				"base_earth:dirt"
			},
			fill_ratio = 0.0005,
			biomes = {
				"base_biomes:deciduous_forest",
				"base_biomes:coniferous_forest",
				"base_biomes:rainforest",
				"base_biomes:rainforest_swamp"
			},
			y_min = -1,
		}
	}
})

pterygota.register_deco("fireflies:firefly_hidden_high", {
	place_on = {
		"base_earth:dirt_with_grass",
		"base_earth:dirt_with_coniferous_litter",
		"base_earth:dirt_with_rainforest_litter",
		"base_earth:dirt"
	},
	place_offset_y = 3,
	fill_ratio = 0.0005,
	biomes = {
		"base_biomes:deciduous_forest",
		"base_biomes:coniferous_forest",
		"base_biomes:rainforest",
		"base_biomes:rainforest_swamp"
	},
	y_min = -1,
	decoration = "fireflies:firefly_hidden",
})

if minetest.get_modpath("farming_api") then
	-- bug net
	minetest.register_tool("fireflies:bug_net", {
		description = S("Bug Net"),
		inventory_image = "fireflies_bugnet.png",
		on_use = function(itemstack, player, pointed_thing)
			local player_name = player and player:get_player_name() or ""
			if not pointed_thing or pointed_thing.type ~= "node" or
					minetest.is_protected(pointed_thing.under, player_name) then
				return
			end
			local node_name = minetest.get_node(pointed_thing.under).name
			local inv = player:get_inventory()
			if minetest.get_item_group(node_name, "catchable") == 1 then
				minetest.set_node(pointed_thing.under, {name = "air"})
				local stack = ItemStack(node_name.." 1")
				local leftover = inv:add_item("main", stack)
				if leftover:get_count() > 0 then
					minetest.add_item(pointed_thing.under, node_name.." 1")
				end
			end
			if not creative.is_enabled(player_name) then
				itemstack:add_wear(256)
				return itemstack
			end
		end
	})

	minetest.register_craft( {
		output = "fireflies:bug_net",
		recipe = {
			{"farming:string", "farming:string"},
			{"farming:string", "farming:string"},
			{"group:stick", ""}
		}
	})
end

if minetest.get_modpath("base_vessels") and minetest.get_modpath("glass_api") then
	-- firefly in a bottle
	pterygota.register_visible("fireflies:firefly_bottle", {
		description = S("Firefly in a Bottle"),
		length = 1.5,
		light_source = 9,
		pointable = true,
		groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
		selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
		},
		sounds = sounds.get_defaults("glass_sounds:glass"),
		on_rightclick = function(pos, node, player, itemstack, pointed_thing)
			local lower_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
			if minetest.is_protected(pos, player:get_player_name()) or
					minetest.get_node(lower_pos).name ~= "air" then
				return
			end

			local upper_pos = {x = pos.x, y = pos.y + 2, z = pos.z}
			local firefly_pos

			if not minetest.is_protected(upper_pos, player:get_player_name()) and
					minetest.get_node(upper_pos).name == "air" then
				firefly_pos = upper_pos
			elseif not minetest.is_protected(lower_pos, player:get_player_name()) then
				firefly_pos = lower_pos
			end

			if firefly_pos then
				minetest.set_node(pos, {name = "vessels:glass_bottle"})
				minetest.set_node(firefly_pos, {name = "fireflies:firefly"})
				minetest.get_node_timer(firefly_pos):start(1)
			end
		end
	})

	minetest.register_craft( {
		output = "fireflies:firefly_bottle",
		recipe = {
			{"fireflies:firefly"},
			{"vessels:glass_bottle"}
		}
	})
end
