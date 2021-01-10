-- earth_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("earth_stairs")

stairs.register_stair_and_slab("earth_stairs:stone", {
	material = "base_earth:stone",
	groups = {cracky = 3},
	tiles = {"base_earth_stone.png"},
	stair_description = S("Stone Stair"),
	slab_description = S("Stone Slab"),
	inner_description = S("Inner Stone Stair"),
	outer_description = S("Outer Stone Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("earth_stairs:stone_cobble", {
	material = "base_earth:stone_cobble",
	groups = {cracky = 3},
	tiles = {"base_earth_stone_cobble.png"},
	stair_description = S("Cobblestone Stair"),
	slab_description = S("Cobblestone Slab"),
	inner_description = S("Inner Cobblestone Stair"),
	outer_description = S("Outer Cobblestone Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("earth_stairs:stonebrick", {
	material = "base_earth:stone_brick",
	groups = {cracky = 2},
	tiles = {"base_earth_stone_brick.png"},
	stair_description = S("Stone Brick Stair"),
	slab_description = S("Stone Brick Slab"),
	inner_description = S("Inner Stone Brick Stair"),
	outer_description = S("Outer Stone Brick Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = false
})

stairs.register_stair_and_slab("earth_stairs:stone_block", {
	material = "base_earth:stone_block",
	groups = {cracky = 2},
	tiles = {"base_earth_stone_block.png"},
	stair_description = S("Stone Block Stair"),
	slab_description = S("Stone Block Slab"),
	inner_description = S("Inner Stone Block Stair"),
	outer_description = S("Outer Stone Block Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("earth_stairs:desert_stone", {
	material = "base_earth:desert_stone",
	groups = {cracky = 3},
	tiles = {"base_earth_desert_stone.png"},
	stair_description = S("Desert Stone Stair"),
	slab_description = S("Desert Stone Slab"),
	inner_description = S("Inner Desert Stone Stair"),
	outer_description = S("Outer Desert Stone Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("earth_stairs:desert_stone_cobble", {
	material = "base_earth:desert_stone_cobble",
	groups = {cracky = 3},
	tiles = {"base_earth_desert_stone_cobble.png"},
	stair_description = S("Desert Cobblestone Stair"),
	slab_description = S("Desert Cobblestone Slab"),
	inner_description = S("Inner Desert Cobblestone Stair"),
	outer_description = S("Outer Desert Cobblestone Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("earth_stairs:desert_stonebrick", {
	material = "base_earth:desert_stone_brick",
	groups = {cracky = 2},
	tiles = {"base_earth_desert_stone_brick.png"},
	stair_description = S("Desert Stone Brick Stair"),
	slab_description = S("Desert Stone Brick Slab"),
	inner_description = S("Inner Desert Stone Brick Stair"),
	outer_description = S("Outer Desert Stone Brick Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = false
})

stairs.register_stair_and_slab("earth_stairs:desert_stone_block", {
	material = "base_earth:desert_stone_block",
	groups = {cracky = 2},
	tiles = {"base_earth_desert_stone_block.png"},
	stair_description = S("Desert Stone Block Stair"),
	slab_description = S("Desert Stone Block Slab"),
	inner_description = S("Inner Desert Stone Block Stair"),
	outer_description = S("Outer Desert Stone Block Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("earth_stairs:sandstone", {
	material = "base_earth:sandstone",
	groups = {crumbly = 1, cracky = 3},
	tiles = {"base_earth_sandstone.png"},
	stair_description = S("Sandstone Stair"),
	slab_description = S("Sandstone Slab"),
	inner_description = S("Inner Sandstone Stair"),
	outer_description = S("Outer Sandstone Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("earth_stairs:sandstonebrick", {
	material = "base_earth:sandstonebrick",
	groups = {cracky = 2},
	tiles = {"base_earth_sandstone_brick.png"},
	stair_description = S("Sandstone Brick Stair"),
	slab_description = S("Sandstone Brick Slab"),
	inner_description = S("Inner Sandstone Brick Stair"),
	outer_description = S("Outer Sandstone Brick Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = false
})

stairs.register_stair_and_slab("earth_stairs:sandstone_block", {
	material = "base_earth:sandstone_block",
	groups = {cracky = 2},
	tiles = {"base_earth_sandstone_block.png"},
	stair_description = S("Sandstone Block Stair"),
	slab_description = S("Sandstone Block Slab"),
	inner_description = S("Inner Sandstone Block Stair"),
	outer_description = S("Outer Sandstone Block Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("earth_stairs:desert_sandstone", {
	material = "base_earth:desert_sandstone",
	groups = {crumbly = 1, cracky = 3},
	tiles = {"base_earth_desert_sandstone.png"},
	stair_description = S("Desert Sandstone Stair"),
	slab_description = S("Desert Sandstone Slab"),
	inner_description = S("Inner Desert Sandstone Stair"),
	outer_description = S("Outer Desert Sandstone Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("earth_stairs:desert_sandstone_brick", {
	material = "base_earth:desert_sandstone_brick",
	groups = {cracky = 2},
	tiles = {"base_earth_desert_sandstone_brick.png"},
	stair_description = S("Desert Sandstone Brick Stair"),
	slab_description = S("Desert Sandstone Brick Slab"),
	inner_description = S("Inner Desert Sandstone Brick Stair"),
	outer_description = S("Outer Desert Sandstone Brick Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = false
})

stairs.register_stair_and_slab("earth_stairs:desert_sandstone_block", {
	material = "base_earth:desert_sandstone_block",
	groups = {cracky = 2},
	tiles = {"base_earth_desert_sandstone_block.png"},
	stair_description = S("Desert Sandstone Block Stair"),
	slab_description = S("Desert Sandstone Block Slab"),
	inner_description = S("Inner Desert Sandstone Block Stair"),
	outer_description = S("Outer Desert Sandstone Block Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("earth_stairs:silver_sandstone", {
	material = "base_earth:silver_sandstone",
	groups = {crumbly = 1, cracky = 3},
	tiles = {"base_earth_silver_sandstone.png"},
	stair_description = S("Silver Sandstone Stair"),
	slab_description = S("Silver Sandstone Slab"),
	inner_description = S("Inner Silver Sandstone Stair"),
	outer_description = S("Outer Silver Sandstone Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = true
})

stairs.register_stair_and_slab("earth_stairs:silver_sandstone_brick", {
	material = "base_earth:silver_sandstone_brick",
	groups = {cracky = 2},
	tiles = {"base_earth_silver_sandstone_brick.png"},
	stair_description = S("Silver Sandstone Brick Stair"),
	slab_description = S("Silver Sandstone Brick Slab"),
	inner_description = S("Inner Silver Sandstone Brick Stair"),
	outer_description = S("Outer Silver Sandstone Brick Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = false
})

stairs.register_stair_and_slab("earth_stairs:silver_sandstone_block", {
	material = "base_earth:silver_sandstone_block",
	groups = {cracky = 2},
	tiles = {"base_earth_silver_sandstone_block.png"},
	stair_description = S("Silver Sandstone Block Stair"),
	slab_description = S("Silver Sandstone Block Slab"),
	inner_description = S("Inner Silver Sandstone Block Stair"),
	outer_description = S("Outer Silver Sandstone Block Stair"),
	sounds = earth.node_sound_stone_defaults(),
	worldaligntex = true
})

