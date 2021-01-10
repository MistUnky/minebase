-- tree_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("tree_stairs")

stairs.register_stair_and_slab("tree_stairs:apple_wood", {
	material = "base_trees:apple_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	tiles = {"base_trees_apple_wood.png"},
	stair_description = S("Wooden Stair"),
	slab_description = S("Wooden Slab"),
	inner_description = S("Inner Wooden Stair"),
	outer_description = S("Outer Wooden Stair"),
	sounds = trees.node_sound_wood_defaults(),
	worldaligntex = false
})

stairs.register_stair_and_slab("tree_stairs:jungle_wood", {
	material = "base_trees:jungle_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	tiles = {"base_trees_jungle_wood.png"},
	stair_description = S("Jungle Wood Stair"),
	slab_description = S("Jungle Wood Slab"),
	inner_description = S("Inner Jungle Wood Stair"),
	outer_description = S("Outer Jungle Wood Stair"),
	sounds = trees.node_sound_wood_defaults(),
	worldaligntex = false
})

stairs.register_stair_and_slab("tree_stairs:pine_wood", {
	material = "base_trees:pine_wood",
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	tiles = {"base_trees_pine_wood.png"},
	stair_description = S("Pine Wood Stair"),
	slab_description = S("Pine Wood Slab"),
	inner_description = S("Inner Pine Wood Stair"),
	outer_description = S("Outer Pine Wood Stair"),
	sounds = trees.node_sound_wood_defaults(),
	worldaligntex = false
})

stairs.register_stair_and_slab("tree_stairs:acacia_wood", {
	material = "base_trees:acacia_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	tiles = {"base_trees_acacia_wood.png"},
	stair_description = S("Acacia Wood Stair"),
	slab_description = S("Acacia Wood Slab"),
	inner_description = S("Inner Acacia Wood Stair"),
	outer_description = S("Outer Acacia Wood Stair"),
	sounds = trees.node_sound_wood_defaults(),
	worldaligntex = false
})

stairs.register_stair_and_slab("tree_stairs:aspen_wood", {
	material = "base_trees:aspen_wood",
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	tiles = {"base_trees_aspen_wood.png"},
	stair_description = S("Aspen Wood Stair"),
	slab_description = S("Aspen Wood Slab"),
	inner_description = S("Inner Aspen Wood Stair"),
	outer_description = S("Outer Aspen Wood Stair"),
	sounds = trees.node_sound_wood_defaults(),
	worldaligntex = false
})
