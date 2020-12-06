-- base_ores/nodes.lua

local S = minetest.get_translator("base_ores")

minetest.register_node("base_ores:stone_with_coal", {
	description = S("Coal Ore"),
	tiles = {"default_stone.png^default_mineral_coal.png"},
	groups = {cracky = 3},
	drop = "base_ores:coal_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_ores:coalblock", {
	description = S("Coal Block"),
	tiles = {"default_coal_block.png"},
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_ores:stone_with_iron", {
	description = S("Iron Ore"),
	tiles = {"default_stone.png^default_mineral_iron.png"},
	groups = {cracky = 2},
	drop = "base_ores:iron_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_ores:steelblock", {
	description = S("Steel Block"),
	tiles = {"default_steel_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})


minetest.register_node("base_ores:stone_with_copper", {
	description = S("Copper Ore"),
	tiles = {"default_stone.png^default_mineral_copper.png"},
	groups = {cracky = 2},
	drop = "base_ores:copper_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_ores:copperblock", {
	description = S("Copper Block"),
	tiles = {"default_copper_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})


minetest.register_node("base_ores:stone_with_tin", {
	description = S("Tin Ore"),
	tiles = {"default_stone.png^default_mineral_tin.png"},
	groups = {cracky = 2},
	drop = "base_ores:tin_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_ores:tinblock", {
	description = S("Tin Block"),
	tiles = {"default_tin_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})


minetest.register_node("base_ores:bronzeblock", {
	description = S("Bronze Block"),
	tiles = {"default_bronze_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})


minetest.register_node("base_ores:stone_with_mese", {
	description = S("Mese Ore"),
	tiles = {"default_stone.png^default_mineral_mese.png"},
	groups = {cracky = 1},
	drop = "base_ores:mese_crystal",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_ores:mese", {
	description = S("Mese Block"),
	tiles = {"default_mese_block.png"},
	paramtype = "light",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
	light_source = 3,
})


minetest.register_node("base_ores:stone_with_gold", {
	description = S("Gold Ore"),
	tiles = {"default_stone.png^default_mineral_gold.png"},
	groups = {cracky = 2},
	drop = "base_ores:gold_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_ores:goldblock", {
	description = S("Gold Block"),
	tiles = {"default_gold_block.png"},
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = default.node_sound_metal_defaults(),
})


minetest.register_node("base_ores:stone_with_diamond", {
	description = S("Diamond Ore"),
	tiles = {"default_stone.png^default_mineral_diamond.png"},
	groups = {cracky = 1},
	drop = "base_ores:diamond",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_ores:diamondblock", {
	description = S("Diamond Block"),
	tiles = {"default_diamond_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_stone_defaults(),
})

