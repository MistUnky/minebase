-- base_trees/extra.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("base_trees")

--
-- apples
--

minetest.register_node("base_trees:apple", {
	description = S("Apple"),
	drawtype = "plantlike",
	tiles = {"base_trees_apple.png"},
	inventory_image = "base_trees_apple.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
	},
	groups = {fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 3, leafdecay_drop = 1, food_apple = 1},
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "base_trees:apple", param2 = 1})
	end,

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if oldnode.param2 == 0 then
			minetest.set_node(pos, {name = "base_trees:apple_mark"})
			minetest.get_node_timer(pos):start(math.random(300, 1500))
		end
	end,
})

minetest.register_node("base_trees:apple_mark", {
	description = S("Apple Marker"),
	inventory_image = "base_trees_apple.png^default_invisible_node_overlay.png",
	wield_image = "base_trees_apple.png^default_invisible_node_overlay.png",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	groups = {not_in_creative_inventory = 1},
	on_timer = function(pos, elapsed)
		if not minetest.find_node_near(pos, 1, "base_trees:leaves") then
			minetest.remove_node(pos)
		elseif minetest.get_node_light(pos) < 11 then
			minetest.get_node_timer(pos):start(200)
		else
			minetest.set_node(pos, {name = "base_trees:apple"})
		end
	end
})

--
-- emergent jungle tree
--

trees.register_sapling("base_trees:emergent_jungle", {
	description = S("Emergent Jungle Tree Sapling"),
	burntime = 7,
	grow_sapling = function(pos)
		minetest.log("action", "An emergent jungle sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		local path = base_trees_path ..
			"/schematics/base_trees_emergent_jungle_from_sapling.mts"
		minetest.place_schematic({x = pos.x - 3, y = pos.y - 5, z = pos.z - 3},
			path, "random", nil, false)
	end,
	minp = {x = -3, y = -5, z = -3},
	maxp = {x = 3, y = 31, z = 3},
})

minetest.register_craft({
	output = "base_trees:emergent_jungle_sapling",
	recipe = {
		{"base_trees:junglesapling", "base_trees:junglesapling", "base_trees:junglesapling"},
		{"base_trees:junglesapling", "base_trees:junglesapling", "base_trees:junglesapling"},
		{"base_trees:junglesapling", "base_trees:junglesapling", "base_trees:junglesapling"},
	}
})

--
-- Register decorations
--

local chunksize = tonumber(minetest.get_mapgen_setting("chunksize"))
if chunksize >= 5 then
	trees.register_tree_decoration("base_trees:emergent_jungle",{
		place_on = {"default:dirt_with_rainforest_litter"},
		sidelen = 80,
		noise_params = {
			offset = 0.0,
			scale = 0.0025,
			spread = {x = 250, y = 250, z = 250},
			seed = 2685,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"rainforest"},
		y_max = 32,
		schematic = minetest.get_modpath("base_trees") ..
				"/schematics/base_trees_emergent_jungle.mts",
		place_offset_y = -4,
	})
end