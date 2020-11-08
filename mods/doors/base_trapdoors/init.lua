-- base_trapdoors/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_trapdoors")

doors.register_trapdoor("base_trapdoors:wood", {
	description = S("Wooden Trapdoor"),
	inventory_image = "base_trapdoors_wood.png",
	wield_image = "base_trapdoors_wood.png",
	tile_front = "base_trapdoors_wood.png",
	tile_side = "base_trapdoors_wood_side.png",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
})

doors.register_trapdoor("base_trapdoors:steel", {
	description = S("Steel Trapdoor"),
	inventory_image = "base_trapdoors_steel.png",
	wield_image = "base_trapdoors_steel.png",
	tile_front = "base_trapdoors_steel.png",
	tile_side = "base_trapdoors_steel_side.png",
	protected = true,
	sounds = default.node_sound_metal_defaults(),
	sound_open = "doors_api_steel_open",
	sound_close = "doors_api_steel_close",
	groups = {cracky = 1, level = 2, door = 1},
})

minetest.register_craft({
	output = "base_trapdoors:wood 2",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
		{"", "", ""},
	}
})

minetest.register_craft({
	output = "base_trapdoors:steel",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot"},
	}
})

----fuels----

minetest.register_craft({
	type = "fuel",
	recipe = "base_trapdoors:wood",
	burntime = 7,
})

