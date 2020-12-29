-- base_signs/init.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("base_signs")

signs.register_sign("base_signs:wood", {
	description = S("Wooden Sign"),
	sounds = trees.node_sound_wood_defaults(),
	groups = {choppy = 2, attached_node = 1, flammable = 2, 
		oddly_breakable_by_hand = 3},
	material = "group:wood",
	burntime = 10
})

signs.register_sign("base_signs:steel", {
	description = S("Steel Sign"), 
	sounds = ores.node_sound_metal_defaults(),
	groups = {cracky = 2, attached_node = 1},
	material = "base_ores:steel_ingot"
})

