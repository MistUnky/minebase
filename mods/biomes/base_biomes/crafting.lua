
minetest.register_craft({
	output = "base_biomes:sandstone",
	recipe = {
		{"base_biomes:sand", "base_biomes:sand"},
		{"base_biomes:sand", "base_biomes:sand"},
	}
})

minetest.register_craft({
	output = "base_biomes:sand 4",
	recipe = {
		{"base_biomes:sandstone"},
	}
})

minetest.register_craft({
	output = "base_biomes:sandstonebrick 4",
	recipe = {
		{"base_biomes:sandstone", "base_biomes:sandstone"},
		{"base_biomes:sandstone", "base_biomes:sandstone"},
	}
})

base_lib.register_19("base_biomes:sandstone_block", "base_biomes:sandstone")

minetest.register_craft({
	output = "base_biomes:desert_sandstone",
	recipe = {
		{"base_biomes:desert_sand", "base_biomes:desert_sand"},
		{"base_biomes:desert_sand", "base_biomes:desert_sand"},
	}
})

minetest.register_craft({
	output = "base_biomes:desert_sand 4",
	recipe = {
		{"base_biomes:desert_sandstone"},
	}
})

minetest.register_craft({
	output = "base_biomes:desert_sandstone_brick 4",
	recipe = {
		{"base_biomes:desert_sandstone", "base_biomes:desert_sandstone"},
		{"base_biomes:desert_sandstone", "base_biomes:desert_sandstone"},
	}
})

base_lib.register_19("base_biomes:desert_sandstone_block", 
	"base_biomes:desert_sandstone")

minetest.register_craft({
	output = "base_biomes:silver_sandstone",
	recipe = {
		{"base_biomes:silver_sand", "base_biomes:silver_sand"},
		{"base_biomes:silver_sand", "base_biomes:silver_sand"},
	}
})

minetest.register_craft({
	output = "base_biomes:silver_sand 4",
	recipe = {
		{"base_biomes:silver_sandstone"},
	}
})

minetest.register_craft({
	output = "base_biomes:silver_sandstone_brick 4",
	recipe = {
		{"base_biomes:silver_sandstone", "base_biomes:silver_sandstone"},
		{"base_biomes:silver_sandstone", "base_biomes:silver_sandstone"},
	}
})

base_lib.register_19("base_biomes:silver_sandstone_block", 
	"base_biomes:silver_sandstone")

minetest.register_craft({
	output = "base_biomes:stonebrick 4",
	recipe = {
		{"base_biomes:stone", "base_biomes:stone"},
		{"base_biomes:stone", "base_biomes:stone"},
	}
})

base_lib.register_19("base_biomes:stone_block", "base_biomes:stone")

minetest.register_craft({
	output = "base_biomes:desert_stonebrick 4",
	recipe = {
		{"base_biomes:desert_stone", "base_biomes:desert_stone"},
		{"base_biomes:desert_stone", "base_biomes:desert_stone"},
	}
})

base_lib.register_19("base_biomes:desert_stone_block", 
	"base_biomes:desert_stone")

base_lib.register_19("base_biomes:snowblock", "base_biomes:snow")




minetest.register_craft({
	type = "cooking",
	output = "base_biomes:stone",
	recipe = "base_biomes:cobble",
})


minetest.register_craft({
	type = "fuel",
	recipe = "base_biomes:lava_source",
	burntime = 60,
})

minetest.register_craft({
	type = "cooking",
	output = "base_biomes:stone",
	recipe = "base_biomes:mossycobble",
})

minetest.register_craft({
	type = "cooking",
	output = "base_biomes:desert_stone",
	recipe = "base_biomes:desert_cobble",
})

