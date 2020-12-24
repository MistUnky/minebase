-- base_trees/init.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("base_trees")
local random = math.random
local base_trees_path = minetest.get_modpath("base_trees")

dofile(base_trees_path .. "/extra.lua")

trees.register_tree("base_trees:apple", {
	tree = {
		description = S("Apple Tree"),
		groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
		burntime = 30
	},
	wood = {
		description = S("Apple Wood Planks"),
		burntime = 7,
	},
	leaves = {
		description = S("Apple Tree Leaves"),
		decay_leaves = {"base_trees:apple", "base_trees:apple_leaves"}
	},
	sapling = {
		description = S("Apple Tree Sapling"),
		groups = {snappy = 2, dig_immediate = 3, flammable = 2, attached_node = 1, 
			sapling = 1},
		burntime = 5,
		minp = {x = -3, y = 1, z = -3},
		maxp = {x = 3, y = 6, z = 3},
		grow_sapling = function(pos)
			minetest.log("action", "A sapling grows into a tree at "..
				minetest.pos_to_string(pos))
			local path = base_trees_path .. "/schematics/apple_tree_from_sapling.mts"
			minetest.place_schematic({x = pos.x - 3, y = pos.y - 1, z = pos.z - 3},
				path, "random", nil, false)
		end
	},
	deco = {
		place_on = {"base_biomes:dirt_with_grass"},
		noise_params = {
			offset = 0.024,
			scale = 0.015,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		schematic = base_trees_path .. "/schematics/base_trees_apple.mts"
	}, 
	deco_log = {
		place_on = {"base_biomes:dirt_with_grass"},
		noise_params = {
			offset = 0.0012,
			scale = 0.0007,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		schematic = base_trees_path .. "/schematics/base_trees_apple_log.mts",
		spawn_by = "base_biomes:dirt_with_grass"
	},
})

trees.register_tree("base_trees:acacia", {
	tree = {
		description = S("Acacia Tree"),
		groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
		burntime = 34
	},
	wood = {
		description = S("Acacia Wood Planks"),
		burntime = 8
	},
	leaves = {
		description = S("Acacia Tree Leaves"),
		decay_r = 2
	},
	sapling = {
		description = S("Acacia Tree Sapling"),
		groups = {snappy = 2, dig_immediate = 3, flammable = 2, attached_node = 1, 
			sapling = 1},
		minp = {x = -4, y = 1, z = -4},
		maxp = {x = 4, y = 7, z = 4},
		burntime = 6,
		grow_sapling = function(pos)
			minetest.log("action", "An acacia sapling grows into a tree at "..
				minetest.pos_to_string(pos))
			local path = base_trees_path .. "/schematics/acacia_tree_from_sapling.mts"
			minetest.place_schematic({x = pos.x - 4, y = pos.y - 1, z = pos.z - 4},
				path, "random", nil, false)
		end
	},
	deco = {
		place_on = {"base_biomes:dry_dirt_with_dry_grass"},
		noise_params = {
			offset = 0,
			scale = 0.002,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"savanna"},
		schematic = base_trees_path .. "/schematics/base_trees_acacia.mts",
	}, 
	deco_log = {
		place_on = {"base_biomes:dry_dirt_with_dry_grass"},
		noise_params = {
			offset = 0,
			scale = 0.001,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"savanna"},
		schematic = base_trees_path .. "/schematics/base_trees_acacia_log.mts",
		spawn_by = "base_biomes:dry_dirt_with_dry_grass",
	}
})

trees.register_tree("base_trees:aspen", {
	tree = {
		description = S("Aspen Tree"),
		groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
		burntime = 22
	},
	wood = {
		description = S("Aspen Wood Planks"),
		burntime = 5
	},
	leaves = {
		description = S("Aspen Tree Leaves")
	},
	sapling = {
		description = S("Aspen Tree Sapling"),
		selection_box = {
			type = "fixed",
			fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16}
		},
		groups = {snappy = 2, dig_immediate = 3, flammable = 3, attached_node = 1, 
			sapling = 1},
		maxp = {x = 2, y = 12, z = 2},
		burntime = 4,
		grow_sapling = function(pos)
			minetest.log("action", "An aspen sapling grows into a tree at "..
				minetest.pos_to_string(pos))
			local path = base_trees_path .. "/schematics/aspen_tree_from_sapling.mts"
			minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
				path, "0", nil, false)
		end
	},
	deco = {
		place_on = {"base_biomes:dirt_with_grass"},
		noise_params = {
			offset = 0.0,
			scale = -0.015,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		schematic = base_trees_path .. "/schematics/base_trees_aspen.mts",
	}, 
	deco_log = {
		place_on = {"base_biomes:dirt_with_grass"},
		noise_params = {
			offset = 0.0,
			scale = -0.0008,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		schematic = base_trees_path .. "/schematics/base_trees_aspen_log.mts",
		spawn_by = "base_biomes:dirt_with_grass"
	}
})

trees.register_tree("base_trees:jungle", {	
	tree = {
		description = S("Jungle Tree"),
		groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
		burntime = 38
	},
	wood = {
		description = S("Jungle Wood Planks"),
		burntime = 9
	},
	leaves = {
		description = S("Jungle Tree Leaves"),
		decay_r = 2
	},
	sapling = {
		description = S("Jungle Tree Sapling"),
		groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
		maxp = {x = 2, y = 15, z = 2},
		burntime = 6,
		grow_sapling = function(pos)
			minetest.log("action", "A jungle sapling grows into a tree at "..
				minetest.pos_to_string(pos))
			local path = base_trees_path .. "/schematics/jungle_tree_from_sapling.mts"
			minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
				path, "random", nil, false)
		end
	},
	deco = {
		place_on = {"base_biomes:dirt_with_rainforest_litter"},
		sidelen = 80,
		fill_ratio = 0.1,
		biomes = {"rainforest"},
		schematic = base_trees_path .. "/schematics/base_trees_jungle.mts",
	}, 
	deco_log = {
		place_on = {"base_biomes:dirt_with_rainforest_litter"},
		sidelen = 80,
		fill_ratio = 0.005,
		biomes = {"rainforest"},
		schematic = base_trees_path .. "/schematics/base_trees_jungle_log.mts",
		spawn_by = "base_biomes:dirt_with_rainforest_litter"
	}
})

trees.register_tree("base_trees:pine", {
	tree = {
		description = S("Pine Tree"),
		groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
		burntime = 26
	}, 
	wood = {
		description = S("Pine Wood Planks"),
		burntime = 6
	},
	leaves = {
		description = S("Pine Needles")
	},
	sapling = {
		description = S("Pine Tree Sapling"),
		groups = {snappy = 2, dig_immediate = 3, flammable = 3,attached_node = 1, 
			sapling = 1},
		burntime = 5,
		grow_sapling = function(pos)
			minetest.log("action", "A pine sapling grows into a tree at "..
				minetest.pos_to_string(pos))
			local path
			if minetest.find_node_near(pos, 1, {"group:snowy"}) then
				if math.random() > 0.5 then
					path = base_trees_path ..
						"/schematics/snowy_pine_tree_from_sapling.mts"
				else
					path = base_trees_path ..
						"/schematics/snowy_small_pine_tree_from_sapling.mts"
				end
				minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
					path, "random", nil, false)
			else
				if math.random() > 0.5 then
					path = base_trees_path ..
						"/schematics/pine_tree_from_sapling.mts"
				else
					path = base_trees_path ..
						"/schematics/small_pine_tree_from_sapling.mts"
				end
				minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
					path, "0", nil, false)
			end
		end
	},
	deco = {
		place_on = {"base_biomes:dirt_with_snow", "base_biomes:dirt_with_coniferous_litter"},
		noise_params = {
			offset = 0.010,
			scale = 0.048,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"taiga", "coniferous_forest"},
		y_min = 4,
		schematic = base_trees_path .. "/schematics/base_trees_pine.mts",
	}, 
	deco_log = {
		place_on = {"base_biomes:dirt_with_snow", "base_biomes:dirt_with_coniferous_litter"},
		sidelen = 80,
		fill_ratio = 0.0018,
		biomes = {"taiga", "coniferous_forest"},
		y_min = 4,
		schematic = base_trees_path .. "/schematics/base_trees_pine_log.mts",
		spawn_by = {"base_biomes:dirt_with_snow", "base_biomes:dirt_with_coniferous_litter"}
	}
})

--
-- Register decorations
--

trees.register_tree_decoration("base_trees:jungle_swamp" , {
	place_on = {"base_biomes:dirt"},
	-- Noise tuned to place swamp trees where papyrus is absent
	noise_params = {
		offset = 0.0,
		scale = -0.1,
		spread = {x = 200, y = 200, z = 200},
		seed = 354,
		octaves = 1,
		persist = 0.5
	},
	biomes = {"rainforest_swamp"},
	y_max = 0,
	y_min = -1,
	schematic = base_trees_path .. "/schematics/base_trees_jungle.mts",
})

trees.register_tree_decoration("base_trees:small_pine", {
	place_on = {"base_biomes:dirt_with_snow", "base_biomes:dirt_with_coniferous_litter"},
	noise_params = {
		offset = 0.010,
		scale = -0.048,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"taiga", "coniferous_forest"},
	y_min = 4,
	schematic = base_trees_path .. "/schematics/base_trees_small_pine.mts",
})

minetest.register_lbm({
	name = "base_trees:convert_saplings_to_node_timer",
	nodenames = {"base_trees:sapling", "base_trees:jungle_sapling",
			"base_trees:pine_sapling", "base_trees:acacia_sapling",
			"base_trees:aspen_sapling"},
	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end
})

