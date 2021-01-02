-- base_rails/init.lua

-- support for Minebase translation.
local S = minetest.get_translator("base_rails")

carts:register_rail("base_rails:rail", {
	description = S("Rail"),
	tiles = {
		"base_rails_straight.png", "base_rails_curved.png",
		"base_rails_t_junction.png", "base_rails_crossing.png"
	},
	inventory_image = "base_rails_straight.png",
	wield_image = "base_rails_straight.png",
	groups = carts:get_rail_groups(),
}, {})

minetest.register_craft({
	output = "base_rails:rail 18",
	recipe = {
		{"base_ores:steel_ingot", "group:wood", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "group:wood", "base_ores:steel_ingot"},
	}
})

carts:register_rail("base_rails:powerrail", {
	description = S("Powered Rail"),
	tiles = {
		"base_rails_straight_pwr.png", "base_rails_curved_pwr.png",
		"base_rails_t_junction_pwr.png", "base_rails_crossing_pwr.png"
	},
	groups = carts:get_rail_groups(),
}, {acceleration = 5})

minetest.register_craft({
	output = "base_rails:powerrail 18",
	recipe = {
		{"base_ores:steel_ingot", "group:wood", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "base_ores:mese_crystal", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "group:wood", "base_ores:steel_ingot"},
	}
})


carts:register_rail("base_rails:brakerail", {
	description = S("Brake Rail"),
	tiles = {
		"base_rails_straight_brk.png", "base_rails_curved_brk.png",
		"base_rails_t_junction_brk.png", "base_rails_crossing_brk.png"
	},
	groups = carts:get_rail_groups(),
}, {acceleration = -3})

minetest.register_craft({
	output = "base_rails:brakerail 18",
	recipe = {
		{"base_ores:steel_ingot", "group:wood", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "base_ores:coal_lump", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "group:wood", "base_ores:steel_ingot"},
	}
})

-- Register rails as dungeon loot
if minetest.global_exists("dungeon_loot") then
	dungeon_loot.register({
		name = "base_rails:rail", chance = 0.35, count = {1, 6}
	})
end
