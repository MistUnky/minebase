-- fancy_bed/init.lua

-- support for Minebase translation.
local S = minetest.get_translator("fancy_bed")

-- Fancy shaped bed

beds.register_bed("fancy_bed:fancy_bed", {
	description = S("Fancy Bed"),
	inventory_image = "fancy_bed_bed_fancy.png",
	wield_image = "fancy_bed_bed_fancy.png",
	tiles = {
		bottom = {
			"fancy_bed_bed_top1.png",
			"fancy_bed_bed_under.png",
			"fancy_bed_bed_side1.png",
			"fancy_bed_bed_side1.png^[transformFX",
			"fancy_bed_bed_foot.png",
			"fancy_bed_bed_foot.png",
		},
		top = {
			"fancy_bed_bed_top2.png",
			"fancy_bed_bed_under.png",
			"fancy_bed_bed_side2.png",
			"fancy_bed_bed_side2.png^[transformFX",
			"fancy_bed_bed_head.png",
			"fancy_bed_bed_head.png",
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
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"", "", "group:stick"},
		{"wool:white", "wool:white", "wool:white"},
		{"group:wood", "group:wood", "group:wood"},
	},
})

-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "fancy_bed:fancy_bed_bottom",
	burntime = 13,
})
