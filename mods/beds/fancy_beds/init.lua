-- fancy_beds/init.lua

-- support for Minebase translation.
local S = minetest.get_translator("fancy_beds")

-- Fancy shaped bed

beds.register_bed("fancy_beds:bed", {
	description = S("Fancy Bed"),
	tiles = {
		bottom = {
			"fancy_beds_bed_top1.png",
			"fancy_beds_bed_under.png",
			"fancy_beds_bed_side1.png",
			"fancy_beds_bed_side1.png^[transformFX",
			"fancy_beds_bed_foot.png",
			"fancy_beds_bed_foot.png",
		},
		top = {
			"fancy_beds_bed_top2.png",
			"fancy_beds_bed_under.png",
			"fancy_beds_bed_side2.png",
			"fancy_beds_bed_side2.png^[transformFX",
			"fancy_beds_bed_head.png",
			"fancy_beds_bed_head.png",
		}
	},
	nodebox = {
		bottom = {
			{-0.5, -0.5, -0.5, -0.375, -0.065, -0.4375},
			{0.375, -0.5, -0.5, 0.5, -0.065, -0.4375},
			{-0.5, -0.375, -0.5, 0.5, -0.125, -0.4375},
			{-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
			{0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
			{-0.4375, -0.3125, -0.4375, 0.4375, -0.0625, 0.5},
		},
		top = {
			{-0.5, -0.5, 0.4375, -0.375, 0.1875, 0.5},
			{0.375, -0.5, 0.4375, 0.5, 0.1875, 0.5},
			{-0.5, 0, 0.4375, 0.5, 0.125, 0.5},
			{-0.5, -0.375, 0.4375, 0.5, -0.125, 0.5},
			{-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
			{0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
			{-0.4375, -0.3125, -0.5, 0.4375, -0.0625, 0.4375},
		}
	},
	selection_box = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"", "", "group:stick"},
		{"wool:white", "wool:white", "wool:white"},
		{"group:wood", "group:wood", "group:wood"},
	},
})

-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "fancy_beds:bed_bottom",
	burntime = 13,
})
