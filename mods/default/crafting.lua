-- mods/default/crafting.lua

minetest.register_craft({
	output = "default:sign_wall_steel 3",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "default:sign_wall_wood 3",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "default:bookshelf",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"default:book", "default:book", "default:book"},
		{"group:wood", "group:wood", "group:wood"},
	}
})

minetest.register_craft({
	output = "default:ladder_wood 5",
	recipe = {
		{"group:stick", "", "group:stick"},
		{"group:stick", "group:stick", "group:stick"},
		{"group:stick", "", "group:stick"},
	}
})

minetest.register_craft({
	output = "default:ladder_steel 15",
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "default:meselamp",
	recipe = {
		{"default:glass"},
		{"default:mese_crystal"},
	}
})

minetest.register_craft({
	output = "default:obsidian",
	recipe = {
		{"default:obsidian_shard", "default:obsidian_shard", "default:obsidian_shard"},
		{"default:obsidian_shard", "default:obsidian_shard", "default:obsidian_shard"},
		{"default:obsidian_shard", "default:obsidian_shard", "default:obsidian_shard"},
	}
})

minetest.register_craft({
	output = "default:obsidianbrick 4",
	recipe = {
		{"default:obsidian", "default:obsidian"},
		{"default:obsidian", "default:obsidian"}
	}
})

minetest.register_craft({
	output = "default:obsidian_block 9",
	recipe = {
		{"default:obsidian", "default:obsidian", "default:obsidian"},
		{"default:obsidian", "default:obsidian", "default:obsidian"},
		{"default:obsidian", "default:obsidian", "default:obsidian"},
	}
})


--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = "default:glass",
	recipe = "group:sand",
})

minetest.register_craft({
	type = "cooking",
	output = "default:obsidian_glass",
	recipe = "default:obsidian_shard",
})


--
-- Fuels
--

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_aspen_wood",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_pine_wood",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_wood",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_acacia_wood",
	burntime = 8,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_junglewood",
	burntime = 9,
})


minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_aspen_wood",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_pine_wood",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_wood",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_acacia_wood",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_junglewood",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:junglegrass",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:papyrus",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:bookshelf",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:ladder_wood",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:sign_wall_wood",
	burntime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:grass_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:dry_grass_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fern_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:marram_grass_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:dry_shrub",
	burntime = 2,
})
