-- moss/init.lua

local S = minetest.get_translator("moss")

earth.register_cobble("moss:stone", {
	description = S("Mossy Cobblestone"),
	groups = {cracky = 3, stone = 1}
})

minetest.register_craft({
	type = "cooking",
	output = "base_earth:stone",
	recipe = "moss:stone_cobble",
})

minetest.register_node("moss:permafrost", {
	description = S("Permafrost with Moss"),
	tiles = {"moss_permafrost.png", "base_earth_permafrost.png",
	{name = "permafrost.png^moss_permafrost_side.png",
		tileable_vertical = false}},
	groups = {cracky = 3},
	drop = "base_earth:permafrost",
	sounds = earth.node_sound_dirt_defaults({
		footstep = {name = "earth_grass_footstep", gain = 0.25},
	})
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"base_earth:permafrost_with_stones"},
	sidelen = 4,
	noise_params = {
		offset = -0.8,
		scale = 2.0,
		spread = {x = 100, y = 100, z = 100},
		seed = 53995,
		octaves = 3,
		persist = 1.0
	}, 	
	biomes = {"base_biomes:tundra"},
	y_max = 50,
	y_min = 2,
	decoration = "moss:permafrost",
	place_offset_y = def.place_offset_y or -1,
	flags = def.flags or "force_placement"
})

--
-- Moss growth on cobble near water
--

local moss_correspondences = {
	["base_earth:cobble"] = "moss:stone_cobble",
	["base_earth:permafrost"] = "moss:permafrost",
	["stairs:slab_cobble"] = "stairs:slab_mossycobble",
	["stairs:stair_cobble"] = "stairs:stair_mossycobble",
	["stairs:stair_inner_cobble"] = "stairs:stair_inner_mossycobble",
	["stairs:stair_outer_cobble"] = "stairs:stair_outer_mossycobble",
	["walls:cobble"] = "walls:mossycobble",
}

minetest.register_abm({
	label = "Moss growth",
	nodenames = {"base_earth:cobble", "stairs:slab_cobble", "stairs:stair_cobble",
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

