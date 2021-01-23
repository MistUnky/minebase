-- base_beds/init.lua

-- support for Minebase translation.
local S = minetest.get_translator("base_beds")

-- Simple shaped bed

beds.register_bed("base_beds:bed", {
	description = S("Simple Bed"),
	inventory_image = "base_beds_inventory.png",
	wield_image = "base_beds_inventory.png",
	tiles = {
		bottom = {
			"base_beds_top_bottom.png^[transformR90",
			"base_beds_under.png",
			"base_beds_side_bottom_r.png",
			"base_beds_side_bottom_r.png^[transformfx",
			"base_beds_transparent.png",
			"base_beds_side_bottom.png"
		},
		top = {
			"base_beds_top_top.png^[transformR90",
			"base_beds_under.png",
			"base_beds_side_top_r.png",
			"base_beds_side_top_r.png^[transformfx",
			"base_beds_side_top.png",
			"base_beds_transparent.png",
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
	recipe = "base_beds:bed_bottom",
	burntime = 12,
})
