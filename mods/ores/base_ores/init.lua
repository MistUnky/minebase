-- base_ores/init.lua

local S = minetest.get_translator("base_ores")

dofile(minetest.get_modpath("base_ores").. "/mapgen.lua")

ores.register_metal("base_ores:copper", {
	lump = {description = S("Copper Lump")},
	ingot = {description = S("Copper Ingot")},
	mineral = {description = S("Copper Ore")},
	block = {description = S("Copper Block")}
})

ores.register_metal("base_ores:gold", {
	lump = {description = S("Gold Lump")},
	ingot = {description = S("Gold Ingot")},
	mineral = {description = S("Gold Ore")},
	block = {description = S("Gold Block")},
})

ores.register_metal("base_ores:tin", {
	lump = {description = S("Tin Lump")},
	ingot = {description = S("Tin Ingot")},
	mineral = {description = S("Tin Ore")},
	block = {description = S("Tin Block")}
})

-- coal 
ores.register_metal("base_ores:coal", {
	lump = {
		description = S("Coal Lump"),
		groups = {coal = 1, flammable = 1}
	},
	mineral = {
		description = S("Coal Ore"),
		groups = {cracky = 3},
	},
	block = {
		description = S("Coal Block"),
		groups = {cracky = 3},
	}
})
ores.register_19("base_ores:coal_block", "base_ores:coal_lump")

minetest.register_craft({
	type = "fuel",
	recipe = "base_ores:coal_lump",
	burntime = 40,
})

minetest.register_craft({
	type = "fuel",
	recipe = "base_ores:coal_block",
	burntime = 370
})

-- iron/steel
ores.register_metal("base_ores:iron", {
	lump = {description = S("Iron Lump")},
	mineral = {description = S("Iron Ore")},
})

ores.register_metal("base_ores:steel", {
	ingot = {description = S("Steel Ingot")},
	block = {description = S("Steel Block")}
})

minetest.register_craft({
	type = "cooking",
	output = "base_ores:steel_ingot",
	recipe = "base_ores:iron_lump",
})

-- bronze
minetest.register_craft({
	output = "base_ores:bronze_ingot 9",
	recipe = {
		{"base_ores:copper_ingot", "base_ores:copper_ingot", "base_ores:copper_ingot"},
		{"base_ores:copper_ingot", "base_ores:tin_ingot", "base_ores:copper_ingot"},
		{"base_ores:copper_ingot", "base_ores:copper_ingot", "base_ores:copper_ingot"},
	}
})

ores.register_metal("base_ores:bronze", {
	ingot = {description = S("Bronze Ingot")},
	block = {description = S("Bronze Block")}
})

-- crystals 
ores.register_crystal("base_ores:diamond", {
	crystal = {description = S("Diamond")},
	mineral = {description = S("Diamond Ore")},
	block = {
		description = S("Diamond Block"),
		groups = {cracky = 1, level = 3}
	}
})

ores.register_crystal("base_ores:mese", {
	crystal = {description = S("Mese Crystal")},
	fragment = {description = S("Mese Crystal Fragment")},
	mineral = {description = S("Mese Ore")},
	block = {description = S("Mese Block")}
})

