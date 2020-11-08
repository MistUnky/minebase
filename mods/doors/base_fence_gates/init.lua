-- base_fence_gates/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_fence_gates")

doors.register_fencegate("base_fence_gates:wood", {
	description = S("Apple Wood Fence Gate"),
	texture = "default_wood.png",
	material = "default:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

doors.register_fencegate("base_fence_gates:acacia_wood", {
	description = S("Acacia Wood Fence Gate"),
	texture = "default_acacia_wood.png",
	material = "default:acacia_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

doors.register_fencegate("base_fence_gates:junglewood", {
	description = S("Jungle Wood Fence Gate"),
	texture = "default_junglewood.png",
	material = "default:junglewood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

doors.register_fencegate("base_fence_gates:pine_wood", {
	description = S("Pine Wood Fence Gate"),
	texture = "default_pine_wood.png",
	material = "default:pine_wood",
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3}
})

doors.register_fencegate("base_fence_gates:aspen_wood", {
	description = S("Aspen Wood Fence Gate"),
	texture = "default_aspen_wood.png",
	material = "default:aspen_wood",
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3}
})


----fuels----

minetest.register_craft({
	type = "fuel",
	recipe = "base_fence_gates:wood_closed",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "base_fence_gates:acacia_wood_closed",
	burntime = 8,
})

minetest.register_craft({
	type = "fuel",
	recipe = "base_fence_gates:junglewood_closed",
	burntime = 9,
})

minetest.register_craft({
	type = "fuel",
	recipe = "base_fence_gates:pine_wood_closed",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "base_fence_gates:aspen_wood_closed",
	burntime = 5,
})
