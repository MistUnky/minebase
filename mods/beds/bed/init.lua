-- bed/init.lua

-- support for Minebase translation.
local S = minetest.get_translator("bed")

-- Simple shaped bed

beds.register_bed("bed:bed", {
	description = S("Simple Bed"),
	inventory_image = "bed_bed.png",
	wield_image = "bed_bed.png",
	tiles = {
		bottom = {
			"bed_bed_top_bottom.png^[transformR90",
			"bed_bed_under.png",
			"bed_bed_side_bottom_r.png",
			"bed_bed_side_bottom_r.png^[transformfx",
			"bed_transparent.png",
			"bed_bed_side_bottom.png"
		},
		top = {
			"bed_bed_top_top.png^[transformR90",
			"bed_bed_under.png",
			"bed_bed_side_top_r.png",
			"bed_bed_side_top_r.png^[transformfx",
			"bed_bed_side_top.png",
			"bed_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.0625, 1.5},
	recipe = {
		{"wool:white", "wool:white", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "bed:bed_bottom",
	burntime = 12,
})
