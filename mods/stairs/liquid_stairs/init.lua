-- liquid_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("liquid_stairs")

stairs.register_stair_and_slab("liquid_stairs:obsidian", {
	material = "base_liquids:obsidian",
	groups = {cracky = 1, level = 2},
	tiles = {"base_liquids_obsidian.png"},
	stair_description = S("Obsidian Stair"),
	slab_description = S("Obsidian Slab"),
	inner_description = S("Inner Obsidian Stair"),
	outer_description = S("Outer Obsidian Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("liquid_stairs:obsidian_brick", {
	material = "base_liquids:obsidian_brick",
	groups = {cracky = 1, level = 2},
	tiles = {"base_liquids_obsidian_brick.png"},
	stair_description = S("Obsidian Brick Stair"),
	slab_description = S("Obsidian Brick Slab"),
	inner_description = S("Inner Obsidian Brick Stair"),
	outer_description = S("Outer Obsidian Brick Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = false
})

stairs.register_stair_and_slab("liquid_stairs:obsidian_block", {
	material = "base_liquids:obsidian_block",
	groups = {cracky = 1, level = 2},
	tiles = {"base_liquids_obsidian_block.png"},
	stair_description = S("Obsidian Block Stair"),
	slab_description = S("Obsidian Block Slab"),
	inner_description = S("Inner Obsidian Block Stair"),
	outer_description = S("Outer Obsidian Block Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("liquid_stairs:ice", {
	material = "base_liquids:ice",
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	tiles = {"base_liquids_ice.png"},
	stair_description = S("Ice Stair"),
	slab_description = S("Ice Slab"),
	inner_description = S("Inner Ice Stair"),
	outer_description = S("Outer Ice Stair"),
	sounds = liquids.node_sound_ice_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("liquid_stairs:snowblock", {
	material = "base_liquids:snowblock",
	groups = {crumbly = 3, cools_lava = 1, snowy = 1},
	tiles = {"base_liquids_snow.png"},
	stair_description = S("Snow Block Stair"),
	slab_description = S("Snow Block Slab"),
	inner_description = S("Inner Snow Block Stair"),
	outer_description = S("Outer Snow Block Stair"),
	sounds = liquids.node_sound_snow_defaults(),
	worldaligntex = true
})

