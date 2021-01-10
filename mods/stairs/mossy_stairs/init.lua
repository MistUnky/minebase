-- mossy_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("mossy_stairs")

stairs.register_stair_and_slab("mossy_stairs:stone_cobble", {
	material = "mossy:stone_cobble",
	groups = {cracky = 3},
	tiles = {"mossy_stone_cobble.png"},
	stair_description = S("Mossy Cobblestone Stair"),
	slab_description = S("Mossy Cobblestone Slab"),
	inner_description = S("Inner Mossy Cobblestone Stair"),
	outer_description = S("Outer Mossy Cobblestone Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = true
})

mossy.register_growth("mossy_stairs:mossy", {
	nodenames = {"mossy_stairs:slab_cobble", "mossy_stairs:stair_cobble", 
		"mossy_stairs:stair_inner_cobble", "mossy_stairs:stair_outer_cobble"},
	map = {
		["earth_stairs:slab_stone_cobble"] = "mossy_stairs:slab_stone_cobble",
		["earth_stairs:stair_stone_cobble"] = "mossy_stairs:stair_stone_cobble",
		["earth_stairs:stair_inner_stone_cobble"] = "mossy_stairs:stair_inner_stone_cobble",
		["earth_stairs:stair_outer_stone_cobble"] = "mossy_stairs:stair_outer_stone_cobble",
	}
})

