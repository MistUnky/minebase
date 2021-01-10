-- clay_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("clay_stairs")

stairs.register_stair_and_slab("clay_stairs:brick", {
	stair_description = S("Brick Stair"),
	slab_description = S("Brick Slab"),
	inner_description = S("Inner Brick Stair"),
	outer_description = S("Outer Brick Stair"),
	material = "clay:brick_block",
	groups = {cracky = 3},
	tiles = {"clay_brick_block.png"},
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = false
})
