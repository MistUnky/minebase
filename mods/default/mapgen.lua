--
-- Aliases for map generators
--

-- All mapgens

-- Stratum ores.

-- Silver sandstone
-- Desert sandstone

-- Sandstone

-- blob ore

-- Silver sand

-- Dirt

-- Gravel


--
-- Register decorations
--

local function register_grass_decoration(offset, scale, length)
	minetest.register_decoration({
		name = "default:grass_" .. length,
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"grassland", "deciduous_forest"},
		y_max = 31000,
		y_min = 1,
		decoration = "default:grass_" .. length,
	})
end

local function register_dry_grass_decoration(offset, scale, length)
	minetest.register_decoration({
		name = "default:dry_grass_" .. length,
		deco_type = "simple",
		place_on = {"default:dry_dirt_with_dry_grass"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"savanna"},
		y_max = 31000,
		y_min = 1,
		decoration = "default:dry_grass_" .. length,
	})
end

local function register_fern_decoration(seed, length)
	minetest.register_decoration({
		name = "default:fern_" .. length,
		deco_type = "simple",
		place_on = {"default:dirt_with_coniferous_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.2,
			spread = {x = 100, y = 100, z = 100},
			seed = seed,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"coniferous_forest"},
		y_max = 31000,
		y_min = 6,
		decoration = "default:fern_" .. length,
	})
end


function default.register_decorations()
	-- Savanna bare dirt patches.
	-- Must come before all savanna decorations that are placed on dry grass.
	-- Noise is similar to long dry grass noise, but scale inverted, to appear
	-- where long dry grass is least dense and shortest.

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dry_dirt_with_dry_grass"},
		sidelen = 4,
		noise_params = {
			offset = -1.5,
			scale = -1.5,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 4,
			persist = 1.0
		},
		biomes = {"savanna"},
		y_max = 31000,
		y_min = 1,
		decoration = "default:dry_dirt",
		place_offset_y = -1,
		flags = "force_placement",
	})

	-- Papyrus

	-- Dirt version for rainforest swamp

	minetest.register_decoration({
		name = "default:papyrus_on_dirt",
		deco_type = "schematic",
		place_on = {"default:dirt"},
		sidelen = 16,
		noise_params = {
			offset = -0.3,
			scale = 0.7,
			spread = {x = 200, y = 200, z = 200},
			seed = 354,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"rainforest_swamp"},
		y_max = 0,
		y_min = 0,
		schematic = minetest.get_modpath("default") .. "/schematics/papyrus_on_dirt.mts",
	})

	-- Dry dirt version for savanna shore

	minetest.register_decoration({
		name = "default:papyrus_on_dry_dirt",
		deco_type = "schematic",
		place_on = {"default:dry_dirt"},
		sidelen = 16,
		noise_params = {
			offset = -0.3,
			scale = 0.7,
			spread = {x = 200, y = 200, z = 200},
			seed = 354,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"savanna_shore"},
		y_max = 0,
		y_min = 0,
		schematic = minetest.get_modpath("default") ..
			"/schematics/papyrus_on_dry_dirt.mts",
	})

	-- Grasses

	register_grass_decoration(-0.03,  0.09,  5)
	register_grass_decoration(-0.015, 0.075, 4)
	register_grass_decoration(0,      0.06,  3)
	register_grass_decoration(0.015,  0.045, 2)
	register_grass_decoration(0.03,   0.03,  1)

	-- Dry grasses

	register_dry_grass_decoration(0.01, 0.05,  5)
	register_dry_grass_decoration(0.03, 0.03,  4)
	register_dry_grass_decoration(0.05, 0.01,  3)
	register_dry_grass_decoration(0.07, -0.01, 2)
	register_dry_grass_decoration(0.09, -0.03, 1)

	-- Ferns

	register_fern_decoration(14936, 3)
	register_fern_decoration(801,   2)
	register_fern_decoration(5,     1)

	-- Junglegrass

	minetest.register_decoration({
		name = "default:junglegrass",
		deco_type = "simple",
		place_on = {"default:dirt_with_rainforest_litter"},
		sidelen = 80,
		fill_ratio = 0.1,
		biomes = {"rainforest"},
		y_max = 31000,
		y_min = 1,
		decoration = "default:junglegrass",
	})

	-- Dry shrub

	minetest.register_decoration({
		name = "default:dry_shrub",
		deco_type = "simple",
		place_on = {"default:desert_sand",
			"default:sand", "default:silver_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.02,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"desert", "sandstone_desert", "cold_desert"},
		y_max = 31000,
		y_min = 2,
		decoration = "default:dry_shrub",
		param2 = 4,
	})

	-- Marram grass

	minetest.register_decoration({
		name = "default:marram_grass",
		deco_type = "simple",
		place_on = {"default:sand"},
		sidelen = 4,
		noise_params = {
			offset = -0.7,
			scale = 4.0,
			spread = {x = 16, y = 16, z = 16},
			seed = 513337,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue, eased"
		},
		biomes = {"coniferous_forest_dunes", "grassland_dunes"},
		y_max = 6,
		y_min = 4,
		decoration = {
			"default:marram_grass_1",
			"default:marram_grass_2",
			"default:marram_grass_3",
		},
	})

	-- Tundra moss

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:permafrost_with_stones"},
		sidelen = 4,
		noise_params = {
			offset = -0.8,
			scale = 2.0,
			spread = {x = 100, y = 100, z = 100},
			seed = 53995,
			octaves = 3,
			persist = 1.0
		},
		biomes = {"tundra"},
		y_max = 50,
		y_min = 2,
		decoration = "default:permafrost_with_moss",
		place_offset_y = -1,
		flags = "force_placement",
	})

	-- Tundra patchy snow

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {
			"default:permafrost_with_moss",
			"default:permafrost_with_stones",
			"default:stone",
			"default:gravel"
		},
		sidelen = 4,
		noise_params = {
			offset = 0,
			scale = 1.0,
			spread = {x = 100, y = 100, z = 100},
			seed = 172555,
			octaves = 3,
			persist = 1.0
		},
		biomes = {"tundra", "tundra_beach"},
		y_max = 50,
		y_min = 1,
		decoration = "default:snow",
	})

	-- Coral reef

	minetest.register_decoration({
		name = "default:corals",
		deco_type = "simple",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 4,
		noise_params = {
			offset = -4,
			scale = 4,
			spread = {x = 50, y = 50, z = 50},
			seed = 7013,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {
			"desert_ocean",
			"savanna_ocean",
			"rainforest_ocean",
		},
		y_max = -2,
		y_min = -8,
		flags = "force_placement",
		decoration = {
			"default:coral_green", "default:coral_pink",
			"default:coral_cyan", "default:coral_brown",
			"default:coral_orange", "default:coral_skeleton",
		},
	})

	-- Kelp

	minetest.register_decoration({
		name = "default:kelp",
		deco_type = "simple",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -10,
		flags = "force_placement",
		decoration = "default:sand_with_kelp",
		param2 = 48,
		param2_max = 96,
	})
end


--
-- Detect mapgen to select functions
--

minetest.clear_registered_decorations()

default.register_decorations()


-- clay

minetest.register_ore({
	ore_type        = "blob",
	ore             = "default:clay",
	wherein         = {"default:sand"},
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 5,
	y_max           = 0,
	y_min           = -15,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = -316,
		octaves = 1,
		persist = 0.0
	},
})

