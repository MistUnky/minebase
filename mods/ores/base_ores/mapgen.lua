-- base_ores/mapgen.lua

minetest.clear_registered_ores()


-- Blob ore.
-- These before scatter ores to avoid other ores in blobs.

-- Scatter ores

-- Coal

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:coal_mineral",
	wherein        = "default:stone",
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 9,
	clust_size     = 3,
	y_max          = 31000,
	y_min          = 1025,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:coal_mineral",
	wherein        = "default:stone",
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 8,
	clust_size     = 3,
	y_max          = 64,
	y_min          = -127,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:coal_mineral",
	wherein        = "default:stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 30,
	clust_size     = 5,
	y_max          = -128,
	y_min          = -31000,
})

-- Tin

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:tin_mineral",
	wherein        = "default:stone",
	clust_scarcity = 10 * 10 * 10,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = 31000,
	y_min          = 1025,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:tin_mineral",
	wherein        = "default:stone",
	clust_scarcity = 13 * 13 * 13,
	clust_num_ores = 4,
	clust_size     = 3,
	y_max          = -64,
	y_min          = -127,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:tin_mineral",
	wherein        = "default:stone",
	clust_scarcity = 10 * 10 * 10,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -128,
	y_min          = -31000,
})

-- Copper

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:copper_mineral",
	wherein        = "default:stone",
	clust_scarcity = 9 * 9 * 9,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = 31000,
	y_min          = 1025,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:copper_mineral",
	wherein        = "default:stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 4,
	clust_size     = 3,
	y_max          = -64,
	y_min          = -127,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:copper_mineral",
	wherein        = "default:stone",
	clust_scarcity = 9 * 9 * 9,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -128,
	y_min          = -31000,
})

-- Iron

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:iron_mineral",
	wherein        = "default:stone",
	clust_scarcity = 9 * 9 * 9,
	clust_num_ores = 12,
	clust_size     = 3,
	y_max          = 31000,
	y_min          = 1025,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:iron_mineral",
	wherein        = "default:stone",
	clust_scarcity = 7 * 7 * 7,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -128,
	y_min          = -255,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:iron_mineral",
	wherein        = "default:stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 29,
	clust_size     = 5,
	y_max          = -256,
	y_min          = -31000,
})

-- Gold

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:gold_mineral",
	wherein        = "default:stone",
	clust_scarcity = 13 * 13 * 13,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = 31000,
	y_min          = 1025,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:gold_mineral",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 3,
	clust_size     = 2,
	y_max          = -256,
	y_min          = -511,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:gold_mineral",
	wherein        = "default:stone",
	clust_scarcity = 13 * 13 * 13,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -512,
	y_min          = -31000,
})

-- Mese crystal

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:mese_mineral",
	wherein        = "default:stone",
	clust_scarcity = 14 * 14 * 14,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = 31000,
	y_min          = 1025,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:mese_mineral",
	wherein        = "default:stone",
	clust_scarcity = 18 * 18 * 18,
	clust_num_ores = 3,
	clust_size     = 2,
	y_max          = -512,
	y_min          = -1023,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:mese_mineral",
	wherein        = "default:stone",
	clust_scarcity = 14 * 14 * 14,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -1024,
	y_min          = -31000,
})

-- Diamond

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:diamond_mineral",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 4,
	clust_size     = 3,
	y_max          = 31000,
	y_min          = 1025,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:diamond_mineral",
	wherein        = "default:stone",
	clust_scarcity = 17 * 17 * 17,
	clust_num_ores = 4,
	clust_size     = 3,
	y_max          = -1024,
	y_min          = -2047,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:diamond_mineral",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 4,
	clust_size     = 3,
	y_max          = -2048,
	y_min          = -31000,
})

-- Mese block

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:mese_mineral",
	wherein        = "default:stone",
	clust_scarcity = 36 * 36 * 36,
	clust_num_ores = 3,
	clust_size     = 2,
	y_max          = 31000,
	y_min          = 1025,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:mese_mineral",
	wherein        = "default:stone",
	clust_scarcity = 36 * 36 * 36,
	clust_num_ores = 3,
	clust_size     = 2,
	y_max          = -2048,
	y_min          = -4095,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "base_ores:mese_mineral",
	wherein        = "default:stone",
	clust_scarcity = 28 * 28 * 28,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -4096,
	y_min          = -31000,
})
