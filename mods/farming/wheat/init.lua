-- wheat/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("wheat")

farming.register_plant("wheat:wheat", {
	description = S("Wheat Seed"),
	harvest_description = S("Wheat"),
	paramtype2 = "meshoptions",
	inventory_image = "wheat_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = farming.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {food_wheat = 1, flammable = 4},
	place_param2 = 3,
})

minetest.register_craftitem("wheat:flour", {
	description = S("Flour"),
	inventory_image = "wheat_flour.png",
	groups = {food_flour = 1, flammable = 1},
})

minetest.register_craftitem("wheat:bread", {
	description = S("Bread"),
	inventory_image = "wheat_bread.png",
	on_use = minetest.item_eat(5),
	groups = {food_bread = 1, flammable = 2},
})

minetest.register_craft({
	type = "shapeless",
	output = "wheat:flour",
	recipe = {"wheat:wheat", "wheat:wheat", "wheat:wheat", "wheat:wheat"}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "wheat:bread",
	recipe = "wheat:flour"
})

-- Straw

minetest.register_craft({
	output = "wheat:straw 3",
	recipe = {
		{"wheat:wheat", "wheat:wheat", "wheat:wheat"},
		{"wheat:wheat", "wheat:wheat", "wheat:wheat"},
		{"wheat:wheat", "wheat:wheat", "wheat:wheat"},
	}
})

minetest.register_craft({
	output = "wheat:wheat 3",
	recipe = {
		{"wheat:straw"},
	}
})

minetest.register_node("wheat:straw", {
	description = S("Straw"),
	tiles = {"wheat_straw.png"},
	is_ground_content = false,
	groups = {snappy=3, flammable=4, fall_damage_add_percent=-30},
	sounds = trees.node_sound_leaves_defaults(),
})

-- Registered before the stairs so the stairs get fuel recipes.
minetest.register_craft({
	type = "fuel",
	recipe = "wheat:straw",
	burntime = 3,
})

if minetest.get_modpath("stairs_api") then
	stairs.register_all("wheat:straw", {
		stair_description = S("Straw Stair"),
		slab_description = S("Straw Slab"), 
		inner_description = S("Inner Straw Stair"),
		outer_description = S("Outer Straw Stair"),
		step_description = S("Straw Step"),
		inner_step_description = S("Inner Straw Step"),
		outer_step_description = S("Outer Straw Step"),
		steps_description = S("Straw Steps"),
		steps_half_description = S("Straw Steps Half"),
		steps_slab_description = S("Straw Steps Slab"),
		material = "wheat:straw",
		groups = {snappy = 3, flammable = 4},
		tiles = {"wheat_straw.png"},
		sounds = trees.node_sound_leaves_defaults(),
		worldaligntex = true
	})
end

-- Fuels

minetest.register_craft({
	type = "fuel",
	recipe = "wheat:wheat",
	burntime = 1,
})

-- Make base_grasses:grass_* occasionally drop wheat seed

for i = 1, 5 do
	minetest.override_item("base_grasses:grass_"..i, {drop = {
		max_items = 1,
		items = {
			{items = {"wheat:seed_wheat"}, rarity = 5},
			{items = {"base_grasses:grass_1"}},
		}
	}})
end


-- Register farming items as dungeon loot

if minetest.global_exists("dungeon_loot") then
	dungeon_loot.register({name = "wheat:wheat", chance = 0.5, count = {2, 5}})
end
