-- glass_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("glass_stairs")

-- Glass stair nodes need to be registered individually to utilize specialized textures.

stairs.register_stair("glass_stairs:common", {
	material = "base_glass:common_glass",
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	tiles = {"glass_stairs_split.png", "base_glass_common_glass.png",
		"glass_stairs_stairside.png^[transformFX", "glass_stairs_stairside.png",
		"base_glass_common_glass.png", "glass_stairs_split.png"},
	description = S("Glass Stair"),
	sounds = glass.node_sound_glass_defaults(),
	worldaligntex = false
})

stairs.register_slab("glass_stairs:common", {
	material = "base_glass:common_glass",
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	tiles = {"base_glass_common_glass.png", "base_glass_common_glass.png", 
		"glass_stairs_split.png"},
	slab_description = S("Glass Slab"),
	sounds = glass.node_sound_glass_defaults(),
	worldaligntex = false
})

stairs.register_inner_stair("glass_stairs:common", {
	material = "base_glass:common_glass",
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	tiles = {"glass_stairs_stairside.png^[transformR270", 
		"base_glass_common_glass.png", "glass_stairs_stairside.png^[transformFX", 
		"base_glass_common_glass.png", "base_glass_common_glass.png", 
		"glass_stairs_stairside.png"},
	inner_description = S("Inner Glass Stair"),
	sounds = glass.node_sound_glass_defaults(),
	worldaligntex = false,
})

stairs.register_outer_stair("glass_stairs:common", {
	material = "base_glass:common_glass",
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	tiles = {"glass_stairs_stairside.png^[transformR90", 
		"base_glass_common_glass.png", "glass_stairs_outer_stairside.png", 
		"glass_stairs_stairside.png", "glass_stairs_stairside.png^[transformR90",
		"glass_stairs_outer_stairside.png"},
	outer_description = S("Outer Glass Stair"),
	sounds = glass.node_sound_glass_defaults(),
	worldaligntex = false,
})

stairs.register_stair("glass_stairs:obsidian_glass", {
	material = "base_glass:obsidian_glass",
	groups = {cracky = 3},
	tiles = {"glass_stairs_obsidian_split.png", "base_glass_obsidian_glass.png",
		"glass_stairs_obsidian_stairside.png^[transformFX", 
		"glass_stairs_obsidian_stairside.png", "base_glass_obsidian_glass.png", 
		"glass_stairs_obsidian_split.png"},
	description = S("Obsidian Glass Stair"),
	sounds = glass.node_sound_glass_defaults(),
	worldaligntex = false
})

stairs.register_slab("glass_stairs:obsidian_glass", {
	material = "base_glass:obsidian_glass",
	groups = {cracky = 3},
	tiles = {"base_glass_obsidian_glass.png", "base_glass_obsidian_glass.png", 
		"glass_stairs_obsidian_split.png"},
	slab_description = S("Obsidian Glass Slab"),
	sounds = glass.node_sound_glass_defaults(),
	worldaligntex = false
})

stairs.register_inner_stair("glass_stairs:obsidian_glass", {
	material = "base_glass:obsidian_glass",
	groups = {cracky = 3},
	tiles = {"glass_stairs_obsidian_stairside.png^[transformR270", 
		"base_glass_obsidian_glass.png",
		"glass_stairs_obsidian_stairside.png^[transformFX", 
		"base_glass_obsidian_glass.png", "base_glass_obsidian_glass.png", 
		"glass_stairs_obsidian_stairside.png"},
	inner_description = S("Inner Obsidian Glass Stair"),
	sounds = glass.node_sound_glass_defaults(),
	worldaligntex = false,
})

stairs.register_outer_stair("glass_stairs:obsidian_glass", {
	material = "base_glass:obsidian_glass",
	groups = {cracky = 3},
	tiles = {"glass_stairs_obsidian_stairside.png^[transformR90", 
		"base_glass_obsidian_glass.png",
		"glass_stairs_obsidian_outer_stairside.png", 
		"glass_stairs_obsidian_stairside.png", 
		"glass_stairs_obsidian_stairside.png^[transformR90",
		"glass_stairs_obsidian_outer_stairside.png"},
	outer_description = S("Outer Obsidian Glass Stair"),
	sounds = glass.node_sound_glass_defaults(),
	worldaligntex = false,
})
