-- mods/default/crafting.lua

minetest.register_craft({
	output = "default:bookshelf",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"default:book", "default:book", "default:book"},
		{"group:wood", "group:wood", "group:wood"},
	}
})

minetest.register_craft({
	output = "default:meselamp",
	recipe = {
		{"default:glass"},
		{"default:mese_crystal"},
	}
})


--
-- Cooking recipes
--


--
-- Fuels
--


minetest.register_craft({
	type = "fuel",
	recipe = "default:bookshelf",
	burntime = 30,
})


