-- meselamp/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("meselamp")

lights.register_light("meselamp:lamp", {
	description = S("Mese Lamp"),
	tiles = {"meselamp_lamp.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = glass.node_sound_glass_defaults(),
	recipe = {
		{"base_glass:common_glass"},
		{"base_ores:mese_crystal"},
	}
})

