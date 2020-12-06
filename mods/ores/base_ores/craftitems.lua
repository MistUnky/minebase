-- base_ores/craftitems.lua 

local S = minetest.get_translator("base_ores")

-- dropped
minetest.register_craftitem("base_ores:clay_lump", {
	description = S("Clay Lump"),
	inventory_image = "default_clay_lump.png",
})

minetest.register_craftitem("base_ores:coal_lump", {
	description = S("Coal Lump"),
	inventory_image = "default_coal_lump.png",
	groups = {coal = 1, flammable = 1}
})

minetest.register_craftitem("base_ores:copper_lump", {
	description = S("Copper Lump"),
	inventory_image = "default_copper_lump.png"
})

minetest.register_craftitem("base_ores:diamond", {
	description = S("Diamond"),
	inventory_image = "default_diamond.png",
})

minetest.register_craftitem("base_ores:gold_lump", {
	description = S("Gold Lump"),
	inventory_image = "default_gold_lump.png"
})

minetest.register_craftitem("base_ores:iron_lump", {
	description = S("Iron Lump"),
	inventory_image = "default_iron_lump.png"
})

minetest.register_craftitem("base_ores:mese_crystal", {
	description = S("Mese Crystal"),
	inventory_image = "default_mese_crystal.png",
})

minetest.register_craftitem("base_ores:tin_lump", {
	description = S("Tin Lump"),
	inventory_image = "default_tin_lump.png"
})

-- ingots

minetest.register_craftitem("base_ores:bronze_ingot", {
	description = S("Bronze Ingot"),
	inventory_image = "default_bronze_ingot.png"
})

minetest.register_craftitem("base_ores:copper_ingot", {
	description = S("Copper Ingot"),
	inventory_image = "default_copper_ingot.png"
})

minetest.register_craftitem("base_ores:gold_ingot", {
	description = S("Gold Ingot"),
	inventory_image = "default_gold_ingot.png"
})

minetest.register_craftitem("base_ores:steel_ingot", {
	description = S("Steel Ingot"),
	inventory_image = "default_steel_ingot.png"
})

minetest.register_craftitem("base_ores:tin_ingot", {
	description = S("Tin Ingot"),
	inventory_image = "default_tin_ingot.png"
})

-- other

minetest.register_craftitem("base_ores:mese_crystal_fragment", {
	description = S("Mese Crystal Fragment"),
	inventory_image = "default_mese_crystal_fragment.png",
})

minetest.register_craftitem("base_ores:clay_brick", {
	description = S("Clay Brick"),
	inventory_image = "default_clay_brick.png",
})

-- recipes

minetest.register_craft({
	output = "base_ores:bronze_ingot 9",
	recipe = {
		{"base_ores:copper_ingot", "base_ores:copper_ingot", "base_ores:copper_ingot"},
		{"base_ores:copper_ingot", "base_ores:tin_ingot", "base_ores:copper_ingot"},
		{"base_ores:copper_ingot", "base_ores:copper_ingot", "base_ores:copper_ingot"},
	}
})

minetest.register_craft({
	output = "base_orebase_ores:copper_ingot 9",
	recipe = {
		{"base_ores:copperblock"},
	}
})

minetest.register_craft({
	output = "base_ores:gold_ingot 9",
	recipe = {
		{"base_ores:goldblock"},
	}
})

minetest.register_craft({
	output = "base_ores:steel_ingot 9",
	recipe = {
		{"base_ores:steelblock"},
	}
})

minetest.register_craft({
	output = "base_ores:tin_ingot 9",
	recipe = {
		{"base_ores:tinblock"},
	}
})

minetest.register_craft({
	output = "base_ores:clay_brick 4",
	recipe = {
		{"base_ores:brick"},
	}
})

minetest.register_craft({
	output = "base_ores:clay_lump 4",
	recipe = {
		{"base_ores:clay"},
	}
})

minetest.register_craft({
	output = "base_ores:coal_lump 9",
	recipe = {
		{"base_ores:coalblock"},
	}
})

minetest.register_craft({
	output = "base_ores:diamond 9",
	recipe = {
		{"base_ores:diamondblock"},
	}
})

minetest.register_craft({
	output = "base_ores:mese_crystal",
	recipe = {
		{"base_ores:mese_crystal_fragment", "base_ores:mese_crystal_fragment", "base_ores:mese_crystal_fragment"},
		{"base_ores:mese_crystal_fragment", "base_ores:mese_crystal_fragment", "base_ores:mese_crystal_fragment"},
		{"base_ores:mese_crystal_fragment", "base_ores:mese_crystal_fragment", "base_ores:mese_crystal_fragment"},
	}
})

minetest.register_craft({
	output = "base_ores:mese_crystal 9",
	recipe = {
		{"base_ores:mese"},
	}
})

minetest.register_craft({
	output = "base_ores:mese_crystal_fragment 9",
	recipe = {
		{"base_ores:mese_crystal"},
	}
})

-- cooking recipes

minetest.register_craft({
	type = "cooking",
	output = "base_ores:copper_ingot",
	recipe = "base_ores:copper_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "base_ores:gold_ingot",
	recipe = "base_ores:gold_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "base_ores:steel_ingot",
	recipe = "base_ores:iron_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "base_ores:tin_ingot",
	recipe = "base_ores:tin_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "base_ores:clay_brick",
	recipe = "base_ores:clay_lump",
})

-- fuel

minetest.register_craft({
	type = "fuel",
	recipe = "base_ores:coal_lump",
	burntime = 40,
})

