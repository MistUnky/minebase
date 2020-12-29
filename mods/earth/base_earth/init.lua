-- base_earth/init.lua 

local S = minetest.get_translator("base_earth")
minetest.register_alias("mapgen_stone", "base_earth:stone")

earth.define_default({stone = "base_earth:stone"})

earth.register_stone_nodes("base_earth:stone", {
	stone = {description = S("Stone")},
	cobble = {description = S("Cobblestone")},
	brick = {description = S("Stone Brick")},
	block = {description = S("Stone Block")}
})

earth.register_cobble("base_earth:mossy_stone", {
	description = S("Mossy Cobblestone"),
	groups = {cracky = 3, stone = 1}
})

minetest.register_craft({
	type = "cooking",
	output = "base_earth:stone",
	recipe = "base_earth:mossy_stone_cobble",
})

earth.register_stone_nodes("base_earth:desert_stone", {
	stone = {description = S("Desert Stone")},
	cobble = {description = S("Desert Cobblestone")},
	brick = {description = S("Desert Stone Brick")},
	block = {description = S("Desert Stone Block")}
})

earth.register_sand_nodes("base_earth:sand", {
	sand = {description = S("Sand")},
	stone = {description = S("Sandstone")},
	brick = {description = S("Sandstone Brick")},
	block = {description = S("Sandstone Block")}
})

earth.register_sand_nodes("base_earth:desert_sand", {
	sand = {description = S("Desert Sand")},
	stone = {description = S("Desert Sandstone")},
	brick = {description = S("Desert Sandstone Brick")},
	block = {description = S("Desert Sandstone Block")}
})

earth.register_sand_nodes("base_earth:silver_sand", {
	sand = {description = S("Silver Sand")},
	stone = {description = S("Silver Sandstone")},
	brick = {description = S("Silver Sandstone Brick")},
	block = {description = S("Silver Sandstone Block")},
	ore = {seed = 2316}
})

earth.register_nodes_with("base_earth:dirt", {
	base_node = {
		description = S("Dirt"),
		groups = {crumbly = 3, soil = 1},
		sounds = earth.node_sound_dirt_defaults(),
	}, {
		with = "grass",
		description = S("Dirt with Grass"),
		gain = 0.25
	},{
		with = "grass_footsteps",
		description = S("Dirt with Grass and Footsteps"),
		tiles = {"base_earth_grass.png^base_earth_footprint.png", 
			"base_earth_dirt.png",
			{name = "base_earth_dirt.png^base_earth_grass_side.png",
				tileable_vertical = false}},
		groups = {crumbly = 3, soil = 1, not_in_creative_inventory = 1},
		gain = 0.25
	}, {
		with = "coniferous_litter",
		description = S("Dirt with Coniferous Litter"),
	},{
		with = "dry_grass",
		description = S("Dirt with Dry Grass"),
	}, {
		with = "rainforest_litter",
		description = S("Dirt with Rainforest Litter"),
	}
})

earth.register_ore("base_earth:dirt", {
	y_min = -31,
	seed = 17676,
	-- Only where default:dirt is present as surface material
	biomes = {"base_biomes:taiga", "base_biomes:snowy_grassland", 
		"base_biomes:grassland", "base_biomes:coniferous_forest",
		"base_biomes:deciduous_forest", "base_biomes:deciduous_forest_shore", 
		"base_biomes:rainforest", "base_biomes:rainforest_swamp"}
})

earth.register_nodes_with("base_earth:dry_dirt", {
	base_node = {
		description = S("Dry Dirt"),
		groups = {crumbly = 3, soil = 1},
		sounds = earth.node_sound_dirt_defaults(),
	}, {
		with = "dry_grass",
		description = S("Dry Dirt with Dry Grass"),
		groups = {crumbly = 3, soil = 1},
	}
})

earth.register_nodes_with("base_earth:permafrost", {
	base_node = {
		description = S("Permafrost"),
		groups = {cracky = 3},
		sounds = earth.node_sound_dirt_defaults(),
	}, {
		with = "stones",
		description = S("Permafrost with Stones"),
		tiles = {"base_earth_permafrost.png^base_earth_stones.png", 
			"base_earth_permafrost.png", {name = "base_earth_permafrost.png" 
			.. "^base_earth_stones_side.png", tileable_vertical = false}},
		groups = {cracky = 3},
		sounds = earth.node_sound_gravel_defaults(),
	}, {
		with = "moss",
		description = S("Permafrost with Moss"),
		groups = {cracky = 3},
		gain = 0.25
	}
})

minetest.register_node("base_earth:gravel", {
	description = S("Gravel"),
	tiles = {"base_earth_gravel.png"},
	groups = {crumbly = 2, falling_node = 1},
	sounds = earth.node_sound_gravel_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {"base_earth:flint"}, rarity = 16},
			{items = {"base_earth:gravel"}}
		}
	}
})

minetest.register_craftitem("base_earth:flint", {
	description = S("Flint"),
	inventory_image = "base_earth_flint.png"
})

earth.register_ore("base_earth:gravel", {seed = 766})

