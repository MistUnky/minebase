-- base_biomes/mapgen.lua

minetest.register_alias("mapgen_stone", "base_biomes:stone")
minetest.register_alias("mapgen_water_source", "base_biomes:water_source")
minetest.register_alias("mapgen_river_water_source", 
	"base_biomes:river_water_source")

biomes.define_default({
	stone_cobble = "base_biomes:stone_cobble",
	mossy_stone_cobble = "base_biomes:mossy_stone_cobble",
	sand = "base_biomes:sand",
	water = "base_biomes:water_source",
	lava = "base_biomes:lava_source"
})

-- Icesheet

biomes.register_biome_set("icesheet", {
	surface = {
		node_dust = "base_biomes:snowblock",
		node_top = "base_biomes:snowblock",
		node_filler = "base_biomes:snowblock",
		node_stone = "base_biomes:cave_ice",
		node_water_top = "base_biomes:ice",
		depth_water_top = 10,
		node_river_water = "base_biomes:ice",
		node_riverbed = "base_biomes:gravel",
		node_dungeon = "base_biomes:ice",
		node_dungeon_stair = "stairs:stair_ice",
		y_min = -8,
		heat_point = 0,
		humidity_point = 73
	}, 
	ocean = {
		node_dust = "base_biomes:snowblock",
		node_water_top = "base_biomes:ice",
		depth_water_top = 10,
		y_max = -9,
	},
	under = {}
})

-- Tundra

biomes.register_biome("tundra_highland", {
	node_dust = "base_biomes:snow",
	node_riverbed = "base_biomes:gravel",
	y_min = 47,
	heat_point = 0,
	humidity_point = 40,
})

biomes.register_biome_set("tundra", {
	surface = {
		node_top = "base_biomes:permafrost_with_stones",
		node_filler = "base_biomes:permafrost",
		depth_filler = 1,
		node_riverbed = "base_biomes:gravel",
		vertical_blend = 4,
		y_max = 46,
		y_min = 2,
		heat_point = 0,
		humidity_point = 40
	},
	ocean = {
		node_riverbed = "base_biomes:gravel",
		y_max = -4,
	},
	under = {}
})

biomes.register_biome("tundra_beach", {
	node_top = "base_biomes:gravel",
	node_filler = "base_biomes:gravel",
	depth_filler = 2,
	node_riverbed = "base_biomes:gravel",
	vertical_blend = 1,
	y_max = 1,
	y_min = -3,
	heat_point = 0,
	humidity_point = 40,
})

-- Taiga

biomes.register_biome_set("taiga", {
	surface = {
		node_dust = "base_biomes:snow",
		node_top = "base_biomes:dirt_with_snow",
		node_filler = "base_biomes:dirt",
		y_min = 4,
		heat_point = 25,
		humidity_point = 70
	},
	ocean = {
		node_dust = "base_biomes:snow",
		y_max = 3,
	},
	under = {}
})

-- Snowy grassland

biomes.register_biome_set("snowy_grassland", {
	surface = {
		node_dust = "base_biomes:snow",
		node_top = "base_biomes:dirt_with_snow",
		node_filler = "base_biomes:dirt",
		depth_filler = 1,
		y_min = 4,
		heat_point = 20,
		humidity_point = 35
	}, 
	ocean = {
		node_dust = "base_biomes:snow",
		y_max = 3,
	},
	under = {}
})

-- Grassland

biomes.register_biome_set("grassland", {
	surface = {
		node_top = "base_biomes:dirt_with_grass",
		node_filler = "base_biomes:dirt",
		depth_filler = 1,
		y_min = 6,
		humidity_point = 35
	},
	ocean = {
		y_max = 3,
		humidity_point = 35,
	},
	under = {}
})

biomes.register_biome("grassland_dunes", {
	node_top = "base_biomes:sand",
	node_filler = "base_biomes:sand",
	depth_filler = 2,
	vertical_blend = 1,
	y_max = 5,
	y_min = 4,
	humidity_point = 35,
})

-- Coniferous forest

biomes.register_biome_set("coniferous_forest", {
	surface = {
		node_top = "base_biomes:dirt_with_coniferous_litter",
		node_filler = "base_biomes:dirt",
		y_min = 6,
		heat_point = 45,
		humidity_point = 70,
	},
	ocean = {
		y_max = 3,
	},
	under = {}
})

biomes.register_biome("coniferous_forest_dunes", {
	node_top = "base_biomes:sand",
	node_filler = "base_biomes:sand",
	vertical_blend = 1,
	y_max = 5,
	y_min = 4,
	heat_point = 45,
	humidity_point = 70,
})

-- Deciduous forest

biomes.register_biome_set("deciduous_forest", {
	surface = {
		node_top = "base_biomes:dirt_with_grass",
		node_filler = "base_biomes:dirt",
		heat_point = 60,
		humidity_point = 68,
	},
	ocean = {
		y_max = -2,
	},
	under = {
		heat_point = 92,
		humidity_point = 16,
	}
})

biomes.register_biome("deciduous_forest_shore", {
	node_top = "base_biomes:dirt",
	node_filler = "base_biomes:dirt",
	y_max = 0,
	y_min = -1,
	heat_point = 60,
	humidity_point = 68,
})

-- Sandstone desert

biomes.register_biome_set("sandstone_desert", {
	surface = {
		node_top = "base_biomes:sand",
		node_filler = "base_biomes:sand",
		depth_filler = 1,
		node_stone = "base_biomes:sandstone",
		node_dungeon = "base_biomes:sandstonebrick",
		node_dungeon_stair = "stairs:stair_sandstone_block",
		y_min = 4,
		heat_point = 60,
		humidity_point = 0,
	}, 
	ocean = {
		node_stone = "base_biomes:sandstone",
		node_dungeon = "base_biomes:sandstonebrick",
		node_dungeon_stair = "stairs:stair_sandstone_block",
		y_max = 3,
	},
	under = {}
})

-- Cold desert

biomes.register_biome_set("cold_desert", {
	surface = {
		node_top = "base_biomes:silver_sand",
		node_filler = "base_biomes:silver_sand",
		depth_filler = 1,
		y_min = 4,
		heat_point = 40,
		humidity_point = 0,
	},
	ocean = {
		y_max = 3,
	},
	under = {}
})

-- Savanna

biomes.register_biome_set("savanna", {
	surface = {
		node_top = "base_biomes:dry_dirt_with_dry_grass",
		node_filler = "base_biomes:dry_dirt",
		depth_filler = 1,
		heat_point = 89,
		humidity_point = 42,
	},
	ocean = {
		y_max = -2,
	},
	under = {}
})

biomes.register_biome("savanna_shore", {
	node_top = "base_biomes:dry_dirt",
	node_filler = "base_biomes:dry_dirt",
	y_max = 0,
	y_min = -1,
	heat_point = 89,
	humidity_point = 42,
})

-- Rainforest

biomes.register_biome_set("rainforest", {
	surface = {
		node_top = "base_biomes:dirt_with_rainforest_litter",
		node_filler = "base_biomes:dirt",
		heat_point = 86,
		humidity_point = 65,
	},
	ocean = {
		y_max = -2,
	},
	under = {}
})

biomes.register_biome("rainforest_swamp", {
	node_top = "base_biomes:dirt",
	node_filler = "base_biomes:dirt",
	y_max = 0,
	y_min = -1,
	heat_point = 86,
	humidity_point = 65,
})


-- stratum ores

biomes.register_stratum("base_biomes:silver_sandstone", {
	wherein = {"base_biomes:stone"},
	y_max = 46,
	y_min = 10,
	offset = 28,
	biomes = {"cold_desert"}
})

biomes.register_stratum("base_biomes:silver_sandstone", {
	wherein = {"base_biomes:stone"},
	y_max = 42,
	y_min = 6,
	offset = 24,
	biomes = {"cold_desert"}
})

biomes.register_stratum("base_biomes:desert_sandstone", {
	wherein = {"base_biomes:desert_stone"},
	y_max = 46,
	y_min = 10,
	offset = 28,
	biomes = {"desert"}
})

biomes.register_stratum("base_biomes:desert_sandstone", {
	wherein = {"base_biomes:desert_stone"},
	y_max = 42,
	y_min = 6,
	offset = 24,
	biomes = {"desert"}
})

biomes.register_stratum("base_biomes:sandstone", {
	wherein = {"base_biomes:desert_stone"},
	y_max = 39,
	y_min = 3,
	offset = 21,
	biomes = {"desert"}
})

