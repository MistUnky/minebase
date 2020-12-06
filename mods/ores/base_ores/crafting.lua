-- base_ores/crafting.lua 

-- recipes 
minetest.register_craft({
	output = "base_ores:coalblock",
	recipe = {
		{"base_ores:coal_lump", "base_ores:coal_lump", "base_ores:coal_lump"},
		{"base_ores:coal_lump", "base_ores:coal_lump", "base_ores:coal_lump"},
		{"base_ores:coal_lump", "base_ores:coal_lump", "base_ores:coal_lump"},
	}
})

minetest.register_craft({
	output = "base_ores:steelblock",
	recipe = {
		{"base_ores:steel_ingot", "base_ores:steel_ingot", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "base_ores:steel_ingot", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "base_ores:steel_ingot", "base_ores:steel_ingot"},
	}
})

minetest.register_craft({
	output = "base_ores:copperblock",
	recipe = {
		{"base_ores:copper_ingot", "base_ores:copper_ingot", "base_ores:copper_ingot"},
		{"base_ores:copper_ingot", "base_ores:copper_ingot", "base_ores:copper_ingot"},
		{"base_ores:copper_ingot", "base_ores:copper_ingot", "base_ores:copper_ingot"},
	}
})

minetest.register_craft({
	output = "base_ores:tinblock",
	recipe = {
		{"base_ores:tin_ingot", "base_ores:tin_ingot", "base_ores:tin_ingot"},
		{"base_ores:tin_ingot", "base_ores:tin_ingot", "base_ores:tin_ingot"},
		{"base_ores:tin_ingot", "base_ores:tin_ingot", "base_ores:tin_ingot"},
	}
})

minetest.register_craft({
	output = "base_ores:bronzeblock",
	recipe = {
		{"base_ores:bronze_ingot", "base_ores:bronze_ingot", "base_ores:bronze_ingot"},
		{"base_ores:bronze_ingot", "base_ores:bronze_ingot", "base_ores:bronze_ingot"},
		{"base_ores:bronze_ingot", "base_ores:bronze_ingot", "base_ores:bronze_ingot"},
	}
})

minetest.register_craft({
	output = "base_ores:bronze_ingot 9",
	recipe = {
		{"base_ores:bronzeblock"},
	}
})

minetest.register_craft({
	output = "base_ores:goldblock",
	recipe = {
		{"base_ores:gold_ingot", "base_ores:gold_ingot", "base_ores:gold_ingot"},
		{"base_ores:gold_ingot", "base_ores:gold_ingot", "base_ores:gold_ingot"},
		{"base_ores:gold_ingot", "base_ores:gold_ingot", "base_ores:gold_ingot"},
	}
})

minetest.register_craft({
	output = "base_ores:diamondblock",
	recipe = {
		{"base_ores:diamond", "base_ores:diamond", "base_ores:diamond"},
		{"base_ores:diamond", "base_ores:diamond", "base_ores:diamond"},
		{"base_ores:diamond", "base_ores:diamond", "base_ores:diamond"},
	}
})

minetest.register_craft({
	output = "base_ores:clay",
	recipe = {
		{"base_ores:clay_lump", "base_ores:clay_lump"},
		{"base_ores:clay_lump", "base_ores:clay_lump"},
	}
})

minetest.register_craft({
	output = "base_ores:brick",
	recipe = {
		{"base_ores:clay_brick", "base_ores:clay_brick"},
		{"base_ores:clay_brick", "base_ores:clay_brick"},
	}
})

minetest.register_craft({
	output = "base_ores:mese",
	recipe = {
		{"base_ores:mese_crystal", "base_ores:mese_crystal", "base_ores:mese_crystal"},
		{"base_ores:mese_crystal", "base_ores:mese_crystal", "base_ores:mese_crystal"},
		{"base_ores:mese_crystal", "base_ores:mese_crystal", "base_ores:mese_crystal"},
	}
})

-- fuel 

minetest.register_craft({
	type = "fuel",
	recipe = "base_ores:coalblock",
	burntime = 370,
})

