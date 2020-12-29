-- ladders/init.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("base_ladders")

ladders.register_ladder("base_ladders:wood", {
	description = S("Wooden Ladder"),
	groups = {choppy = 2, oddly_breakable_by_hand = 3, flammable = 2},
	sounds = trees.node_sound_wood_defaults(),
	material = "group:stick",
	output_count = 5,
	burntime = 7
})

ladders.register_ladder("base_ladders:steel", {
	description = S("Steel Ladder"),
	groups = {cracky = 2},
	sounds = ores.node_sound_metal_defaults(),
	material = "base_ores:steel_ingot",
	output_count = 15
})


