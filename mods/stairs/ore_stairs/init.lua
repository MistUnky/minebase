-- ore_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("ore_stairs")

stairs.register_stair_and_slab("ore_stairs:steel_block", {
	material = "base_ores:steel_block",
	groups = {cracky = 1, level = 2},
	tiles = {"base_ores_steel_block.png"},
	stair_description = S("Steel Block Stair"),
	slab_description = S("Steel Block Slab"),
	inner_description = S("Inner Steel Block Stair"),
	outer_description = S("Outer Steel Block Stair"),
	sounds = ores.node_sound_metal_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("ore_stairs:tin_block", {
	material = "base_ores:tin_block",
	groups = {cracky = 1, level = 2},
	tiles = {"base_ores_tin_block.png"},
	stair_description = S("Tin Block Stair"),
	slab_description = S("Tin Block Slab"),
	inner_description = S("Inner Tin Block Stair"),
	outer_description = S("Outer Tin Block Stair"),
	sounds = ores.node_sound_metal_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("ore_stairs:copper_block", {
	material = "base_ores:copper_block",
	groups = {cracky = 1, level = 2},
	tiles = {"base_ores_copper_block.png"},
	stair_description = S("Copper Block Stair"),
	slab_description = S("Copper Block Slab"),
	inner_description = S("Inner Copper Block Stair"),
	outer_description = S("Outer Copper Block Stair"),
	sounds = ores.node_sound_metal_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("ore_stairs:bronze_block", {
	material = "base_ores:bronze_block",
	groups = {cracky = 1, level = 2},
	tiles = {"base_ores_bronze_block.png"},
	stair_description = S("Bronze Block Stair"),
	slab_description = S("Bronze Block Slab"),
	inner_description = S("Inner Bronze Block Stair"),
	outer_description = S("Outer Bronze Block Stair"),
	sounds = ores.node_sound_metal_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("ore_stairs:gold_block", {
	material = "base_ores:gold_block",
	groups = {cracky = 1},
	tiles = {"base_ores_gold_block.png"},
	stair_description = S("Gold Block Stair"),
	slab_description = S("Gold Block Slab"),
	inner_description = S("Inner Gold Block Stair"),
	outer_description = S("Outer Gold Block Stair"),
	sounds = ores.node_sound_metal_defaults(),
	worldaligntex = true
})
