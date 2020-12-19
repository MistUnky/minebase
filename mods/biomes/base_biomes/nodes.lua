-- base_biomes/nodes.lua 

local S = minetest.get_translator("base_biomes")

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
	sounds = default.node_sound_snow_defaults(),

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "base_biomes:dirt_with_grass" then
			minetest.set_node(pos, {name = "base_biomes:dirt_with_snow"})
		end
	end,
})

minetest.register_node("base_biomes:snowblock", {
	description = S("Snow Block"),
	tiles = {"base_biomes_snow.png"},
	groups = {crumbly = 3, cools_lava = 1, snowy = 1},
	sounds = default.node_sound_snow_defaults(),

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "base_biomes:dirt_with_grass" then
			minetest.set_node(pos, {name = "base_biomes:dirt_with_snow"})
		end
	end,
})

minetest.register_node("base_biomes:dirt_with_snow", {
	description = S("Dirt with Snow"),
	tiles = {"base_biomes_snow.png", "base_biomes_dirt.png",
		{name = "base_biomes_dirt.png^base_biomes_snow_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1, snowy = 1},
	drop = "base_biomes:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "base_biomes_snow_footstep", gain = 0.2},
	}),
})

-- Mapgen-placed ice with 'is ground content = true' to contain tunnels
minetest.register_node("base_biomes:cave_ice", {
	description = S("Cave Ice"),
	tiles = {"base_biomes_ice.png"},
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3,
		not_in_creative_inventory = 1},
	drop = "base_biomes:ice",
	sounds = default.node_sound_ice_defaults(),
})

-- 'is ground content = false' to avoid tunnels in sea ice or ice rivers
minetest.register_node("base_biomes:ice", {
	description = S("Ice"),
	tiles = {"base_biomes_ice.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	sounds = default.node_sound_ice_defaults(),
})

minetest.register_node("base_biomes:dirt", {
	description = S("Dirt"),
	tiles = {"base_biomes_dirt.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("base_biomes:gravel", {
	description = S("Gravel"),
	tiles = {"base_biomes_gravel.png"},
	groups = {crumbly = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {"default:flint"}, rarity = 16},
			{items = {"base_biomes:gravel"}}
		}
	}
})

minetest.register_node("base_biomes:water_source", {
	description = S("Water Source"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "base_biomes_water_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "base_biomes_water_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	alpha = 191,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "base_biomes:water_flowing",
	liquid_alternative_source = "base_biomes:water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("base_biomes:water_flowing", {
	description = S("Flowing Water"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"base_biomes_water.png"},
	special_tiles = {
		{
			name = "base_biomes_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "base_biomes_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	alpha = 191,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "base_biomes:water_flowing",
	liquid_alternative_source = "base_biomes:water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("base_biomes:lava_source", {
	description = S("Lava Source"),
	drawtype = "liquid",
	tiles = {
		{
			name = "base_biomes_lava_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
		{
			name = "base_biomes_lava_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	paramtype = "light",
	light_source = default.LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "base_biomes:lava_flowing",
	liquid_alternative_source = "base_biomes:lava_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {lava = 3, liquid = 2, igniter = 1},
})

minetest.register_node("base_biomes:lava_flowing", {
	description = S("Flowing Lava"),
	drawtype = "flowingliquid",
	tiles = {"base_biomes_lava.png"},
	special_tiles = {
		{
			name = "base_biomes_lava_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "base_biomes_lava_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = default.LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "base_biomes:lava_flowing",
	liquid_alternative_source = "base_biomes:lava_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {lava = 3, liquid = 2, igniter = 1,
		not_in_creative_inventory = 1},
})

minetest.register_node("base_biomes:permafrost", {
	description = S("Permafrost"),
	tiles = {"base_biomes_permafrost.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("base_biomes:permafrost_with_stones", {
	description = S("Permafrost with Stones"),
	tiles = {"base_biomes_permafrost.png^base_biomes_stones.png",
		"base_biomes_permafrost.png",
		"base_biomes_permafrost.png^base_biomes_stones_side.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_gravel_defaults(),
})

minetest.register_node("base_biomes:dirt_with_grass", {
	description = S("Dirt with Grass"),
	tiles = {"base_biomes_grass.png", "base_biomes_dirt.png",
		{name = "base_biomes_dirt.png^base_biomes_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "base_biomes:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("base_biomes:dirt_with_grass_footsteps", {
	description = S("Dirt with Grass and Footsteps"),
	tiles = {"base_biomes_grass.png^base_biomes_footprint.png", "base_biomes_dirt.png",
		{name = "base_biomes_dirt.png^base_biomes_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, not_in_creative_inventory = 1},
	drop = "base_biomes:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("base_biomes:dirt_with_coniferous_litter", {
	description = S("Dirt with Coniferous Litter"),
	tiles = {
		"base_biomes_coniferous_litter.png",
		"base_biomes_dirt.png",
		{name = "base_biomes_dirt.png^base_biomes_coniferous_litter_side.png",
			tileable_vertical = false}
	},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "base_biomes:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("base_biomes:desert_stone", {
	description = S("Desert Stone"),
	tiles = {"base_biomes_desert_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "base_biomes:desert_cobble",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_biomes:desert_cobble", {
	description = S("Desert Cobblestone"),
	tiles = {"base_biomes_desert_cobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

biomes.register_sand("base_biomes:sand", {
	sand_node = {description = S("Sand")},
	sandstone = {description = S("Sandstone")},
	sandstone_brick = {description = S("Sandstone Brick")},
	sandstone_block = {description = S("Sandstone Block")}
})

biomes.register_sand("base_biomes:desert_sand", {
	sand_node = {description = S("Desert Sand")},
	sandstone = {description = S("Desert Sandstone")},
	sandstone_brick = {description = S("Desert Sandstone Brick")},
	sandstone_block = {description = S("Desert Sandstone Block")}
})

biomes.register_sand("base_biomes:silver_sand", {
	sand_node = {description = S("Silver Sand")},
	sandstone = {description = S("Silver Sandstone")},
	sandstone_brick = {description = S("Silver Sandstone Brick")},
	sandstone_block = {description = S("Silver Sandstone Block")}
})

minetest.register_node("base_biomes:dry_dirt", {
	description = S("Savanna Dirt"),
	tiles = {"base_biomes_dry_dirt.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("base_biomes:dry_dirt_with_dry_grass", {
	description = S("Savanna Dirt with Savanna Grass"),
	tiles = {"base_biomes_dry_grass.png", "base_biomes_dry_dirt.png",
		{name = "base_biomes_dry_dirt.png^base_biomes_dry_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1},
	drop = "base_biomes:dry_dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("base_biomes:dirt_with_dry_grass", {
	description = S("Dirt with Savanna Grass"),
	tiles = {"base_biomes_dry_grass.png",
		"base_biomes_dirt.png",
		{name = "base_biomes_dirt.png^base_biomes_dry_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "base_biomes:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("base_biomes:dirt_with_rainforest_litter", {
	description = S("Dirt with Rainforest Litter"),
	tiles = {
		"base_biomes_rainforest_litter.png",
		"base_biomes_dirt.png",
		{name = "base_biomes_dirt.png^base_biomes_rainforest_litter_side.png",
			tileable_vertical = false}
	},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "base_biomes:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("base_biomes:stone", {
	description = S("Stone"),
	tiles = {"base_biomes_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "base_biomes:cobble",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_biomes:cobble", {
	description = S("Cobblestone"),
	tiles = {"base_biomes_cobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_biomes:mossycobble", {
	description = S("Mossy Cobblestone"),
	tiles = {"base_biomes_mossycobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_biomes:stonebrick", {
	description = S("Stone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_biomes:stone_block", {
	description = S("Stone Block"),
	tiles = {"default_stone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_biomes:desert_stonebrick", {
	description = S("Desert Stone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_desert_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_biomes:desert_stone_block", {
	description = S("Desert Stone Block"),
	tiles = {"default_desert_stone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("base_biomes:river_water_source", {
	description = S("River Water Source"),
	drawtype = "liquid",
	tiles = {
		{
			name = "base_biomes_river_water_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "base_biomes_river_water_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	alpha = 160,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "base_biomes:river_water_flowing",
	liquid_alternative_source = "base_biomes:river_water_source",
	liquid_viscosity = 1,
	-- Not renewable to avoid horizontal spread of water sources in sloping
	-- rivers that can cause water to overflow riverbanks and cause floods.
	-- River water source is instead made renewable by the 'force renew'
	-- option used in the 'bucket' mod by the river water bucket.
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("base_biomes:river_water_flowing", {
	description = S("Flowing River Water"),
	drawtype = "flowingliquid",
	tiles = {"base_biomes_river_water.png"},
	special_tiles = {
		{
			name = "base_biomes_river_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "base_biomes_river_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	alpha = 160,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "base_biomes:river_water_flowing",
	liquid_alternative_source = "base_biomes:river_water_source",
	liquid_viscosity = 1,
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})

