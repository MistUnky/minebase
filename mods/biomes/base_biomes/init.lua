-- base_biomes/init.lua 

local S = minetest.get_translator("base_biomes")
local path = minetest.get_modpath("base_biomes")

dofile(path .. "/mapgen.lua")

biomes.register_stone_nodes("base_biomes:stone", {
	stone = {description = S("Stone")},
	cobble = {description = S("Cobblestone")},
	brick = {description = S("Stone Brick")},
	block = {description = S("Stone Block")}
})

biomes.register_cobble("base_biomes:mossy_stone", {
	description = S("Mossy Cobblestone"),
	groups = {cracky = 3, stone = 1}
})

minetest.register_craft({
	type = "cooking",
	output = "base_biomes:stone",
	recipe = "base_biomes:mossy_stone_cobble",
})

biomes.register_stone_nodes("base_biomes:desert_stone", {
	stone = {description = S("Desert Stone")},
	cobble = {description = S("Desert Cobblestone")},
	brick = {description = S("Desert Stone Brick")},
	block = {description = S("Desert Stone Block")}
})

biomes.register_sand_nodes("base_biomes:sand", {
	sand = {description = S("Sand")},
	stone = {description = S("Sandstone")},
	brick = {description = S("Sandstone Brick")},
	block = {description = S("Sandstone Block")}
})

biomes.register_sand_nodes("base_biomes:desert_sand", {
	sand = {description = S("Desert Sand")},
	stone = {description = S("Desert Sandstone")},
	brick = {description = S("Desert Sandstone Brick")},
	block = {description = S("Desert Sandstone Block")}
})

biomes.register_sand_nodes("base_biomes:silver_sand", {
	sand = {description = S("Silver Sand")},
	stone = {description = S("Silver Sandstone")},
	brick = {description = S("Silver Sandstone Brick")},
	block = {description = S("Silver Sandstone Block")}
})

biomes.register_nodes_with("base_biomes:dirt", {
	base_node = {
		description = S("Dirt"),
		groups = {crumbly = 3, soil = 1},
		sounds = biomes.node_sound_dirt_defaults(),
	},{
		with = "snow",
		description = S("Dirt with Snow"),
		groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1, snowy = 1},
		sounds = biomes.node_sound_dirt_defaults({
			footstep = {name = "base_biomes_snow_footstep", gain = 0.2},
		})
	}, {
		with = "grass",
		description = S("Dirt with Grass"),
		gain = 0.25
	},{
		with = "grass_footsteps",
		description = S("Dirt with Grass and Footsteps"),
		tiles = {"base_biomes_grass.png^base_biomes_footprint.png", 
			"base_biomes_dirt.png",
			{name = "base_biomes_dirt.png^base_biomes_grass_side.png",
				tileable_vertical = false}},
		groups = {crumbly = 3, soil = 1, not_in_creative_inventory = 1},
		gain = 0.25
	}, {
		with = "coniferous_litter",
		description = S("Dirt with Coniferous Litter"),
	},{
		with = "dry_grass",
		description = S("Dirt with Dry Grass"),
	}, {
		with = "rainforest_litter",
		description = S("Dirt with Rainforest Litter"),
	}
})

biomes.register_nodes_with("base_biomes:dry_dirt", {
	base_node = {
		description = S("Dry Dirt"),
		groups = {crumbly = 3, soil = 1},
		sounds = biomes.node_sound_dirt_defaults(),
	}, {
		with = "dry_grass",
		description = S("Dry Dirt with Dry Grass"),
		groups = {crumbly = 3, soil = 1},
	}
})

biomes.register_nodes_with("base_biomes:permafrost", {
	base_node = {
		description = S("Permafrost"),
		groups = {cracky = 3},
		sounds = biomes.node_sound_dirt_defaults(),
	}, {
		with = "stones",
		description = S("Permafrost with Stones"),
		tiles = {"base_biomes_permafrost.png^base_biomes_stones.png", 
			"base_biomes_permafrost.png", {name = "base_biomes_permafrost.png" 
			.. "^base_biomes_stones_side.png", tileable_vertical = false}},
		groups = {cracky = 3},
		sounds = biomes.node_sound_gravel_defaults(),
	}, {
		with = "moss",
		description = S("Permafrost with Moss"),
		groups = {cracky = 3},
		gain = 0.25
	}
})

biomes.register_liquid("base_biomes:water", {
	source = {
		description = S("Water Source"),
		waving = 3,
		alpha = 191,
		post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	},
	flowing = {
		description = S("Flowing Water"),
		waving = 3,
		length = 0.5,
		alpha = 191,
		groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,
			cools_lava = 1},
	}
})

biomes.register_liquid("base_biomes:river_water", {
	source = {
		description = S("River Water Source"),
		alpha = 160,
		-- Not renewable to avoid horizontal spread of water sources in sloping
		-- rivers that can cause water to overflow riverbanks and cause floods.
		-- River water source is instead made renewable by the 'force renew'
		-- option used in the 'bucket' mod by the river water bucket.
		liquid_renewable = false,
		liquid_range = 2,
		post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	},
	flowing = {
		description = S("Flowing River Water"),
		length = 0.5,
		alpha = 160,
		liquid_renewable = false,
		liquid_range = 2,
		groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,
			cools_lava = 1},
	}
})

biomes.register_liquid("base_biomes:lava", {
	source = {
		description = S("Lava Source"),
		length = 3.0,
		light_source = biomes.LIGHT_MAX - 1,
		liquid_viscosity = 7,
		liquid_renewable = false,
		damage_per_second = 4 * 2,
		post_effect_color = {a = 191, r = 255, g = 64, b = 0},
		groups = {lava = 3, liquid = 2, igniter = 1},
	},
	flowing = {
		description = S("Flowing Lava"),
		length = 3.3,
		light_source = biomes.LIGHT_MAX - 1,
		liquid_viscosity = 7,
		liquid_renewable = false,
		damage_per_second = 4 * 2,
		groups = {lava = 3, liquid = 2, igniter = 1,
			not_in_creative_inventory = 1},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "base_biomes:lava_source",
	burntime = 60,
})

minetest.register_node("base_biomes:snow", {
	description = S("Snow"),
	tiles = {"base_biomes_snow.png"},
	inventory_image = "base_biomes_snowball.png",
	wield_image = "base_biomes_snowball.png",
	paramtype = "light",
	buildable_to = true,
	floodable = true,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -6 / 16, 0.5},
		},
	},
	groups = {crumbly = 3, falling_node = 1, snowy = 1},
	sounds = biomes.node_sound_snow_defaults(),

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "base_biomes:dirt_with_grass" then
			minetest.set_node(pos, {name = "base_biomes:dirt_with_snow"})
		end
	end,
})

base_lib.register_craft19("base_biomes:snowblock", "base_biomes:snow")

minetest.register_node("base_biomes:snowblock", {
	description = S("Snow Block"),
	tiles = {"base_biomes_snow.png"},
	groups = {crumbly = 3, cools_lava = 1, snowy = 1},
	sounds = biomes.node_sound_snow_defaults(),

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "base_biomes:dirt_with_grass" then
			minetest.set_node(pos, {name = "base_biomes:dirt_with_snow"})
		end
	end,
})

-- Mapgen-placed ice with 'is ground content = true' to contain tunnels
minetest.register_node("base_biomes:cave_ice", {
	description = S("Cave Ice"),
	tiles = {"base_biomes_ice.png"},
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3,
		not_in_creative_inventory = 1},
	drop = "base_biomes:ice",
	sounds = biomes.node_sound_ice_defaults(),
})

-- 'is ground content = false' to avoid tunnels in sea ice or ice rivers
minetest.register_node("base_biomes:ice", {
	description = S("Ice"),
	tiles = {"base_biomes_ice.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	sounds = biomes.node_sound_ice_defaults(),
})

minetest.register_node("base_biomes:gravel", {
	description = S("Gravel"),
	tiles = {"base_biomes_gravel.png"},
	groups = {crumbly = 2, falling_node = 1},
	sounds = biomes.node_sound_gravel_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {"base_biomes:flint"}, rarity = 16},
			{items = {"base_biomes:gravel"}}
		}
	}
})

minetest.register_craftitem("base_biomes:flint", {
	description = S("Flint"),
	inventory_image = "base_biomes_flint.png"
})

