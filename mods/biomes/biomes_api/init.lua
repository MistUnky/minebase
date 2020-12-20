-- biomes_api/init.lua

biomes = {}

minetest.clear_registered_biomes()

--
-- Nodes
-- 

function biomes.register_stone(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description or txt,
		tiles = def.tiles or {txt .. ".png"},
		groups = def.groups or {cracky = 3},
		sounds = def.sounds or default.node_sound_stone_defaults()
	})
end

function biomes.register_brick(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "_brick", {
		description = def.description or txt,
		paramtype2 = def.paramtype2 or "facedir",
		place_param2 = def.place_param2 or 0,
		tiles = def.tiles or {txt .. "_brick.png"},
		is_ground_content = def.is_ground_content or false,
		groups = def.groups or {cracky = 2},
		sounds = def.sounds or default.node_sound_stone_defaults()
	})
end

function biomes.register_block(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "_block", {
		description = def.description or txt,
		tiles = def.tiles or {txt .. "_block.png"},
		is_ground_content = def.is_ground_content or false,
		groups = def.groups or {cracky = 2},
		sounds = def.sounds or default.node_sound_stone_defaults()
	})
end

function biomes.register_cobble(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "_cobble", {
		description = def.description or txt,
		tiles = def.tiles or {txt .. "_cobble.png"},
		is_ground_content = def.is_ground_content or false,
		groups = def.groups or {cracky = 3},
		sounds = def.sounds or default.node_sound_stone_defaults()
	})
end

function biomes.register_stone_nodes(name, def)
	if def.cobble then
		def.cobble.groups = def.cobble.groups or {cracky = 3, stone = 2}
		biomes.register_cobble(name, def.cobble)
		def.stone.drop = def.stone.drop or name .. "_cobble"

		minetest.register_craft({
			type = "cooking",
			output = name,
			recipe = name .. "_cobble"
		})
	end

	def.stone.groups = def.stone.groups or {cracky = 3, stone = 1}
	biomes.register_stone(name, def.stone)

	if def.brick then
		def.brick.groups = def.brick.groups or {cracky = 2, stone = 1},
		biomes.register_brick(name, def.brick)
		base_lib.register_craft44(name .. "_brick", name)
	end

	if def.block then
		def.block.groups = def.block.groups or {cracky = 2, stone = 1}
		biomes.register_block(name, def.block)
		base_lib.register_craft19(name .. "_block", name)
	end
end

function biomes.register_sand(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description or txt,
		tiles = def.tiles or {txt .. ".png"},
		groups = def.groups or {crumbly = 3, falling_node = 1, sand = 1},
		sounds = def.sounds or default.node_sound_sand_defaults(),
	})
end

function biomes.register_sand_nodes(name, def)
	local namestone = name .. "stone"
	biomes.register_sand(name, def.sand)

	if def.stone then
		base_lib.register_craft14(namestone, name)
		def.stone.groups = def.stone.groups or {cracky = 3, crumbly = 1},
		biomes.register_stone(namestone, def.stone)

		if def.brick then
			base_lib.register_craft44(namestone .. "_brick 4", namestone)
		end

		if def.block then
			base_lib.register_craft19(namestone .. "_block", namestone)
		end
	end

	if def.brick then
		biomes.register_brick(namestone, def.brick)
	end

	if def.block then
		biomes.register_block(namestone, def.block)
	end
end

function biomes.register_node_with(name, def)
	local txt = name:gsub(":", "_")
	local txt_with = string.sub(name, 1, name:find(":") - 1) .. "_" .. def.with
	minetest.register_node(name .. "_with_" .. def.with, {
		description = def.description or txt .. "_with_" .. def.with,
		tiles = def.tiles or {txt_with .. ".png", txt .. ".png",
		{name = txt .. ".png^" .. txt_with .. "_side.png",
			tileable_vertical = false}},
		groups = def.groups or {crumbly = 3, soil = 1, spreading_dirt_type = 1},
		drop = def.drop or name,
		sounds = def.sounds or default.node_sound_dirt_defaults({
			footstep = {name = "default_grass_footstep", gain = def.gain or 0.4},
		})
	})
end

function biomes.register_nodes_with(name, def)
	def.base_node.tiles = def.base_node.tiles or {name:gsub(":", "_") .. ".png"}
	minetest.register_node(name, def.base_node)

	for _, de in ipairs(def) do
		biomes.register_node_with(name, de)
	end
end

function biomes.register_liquid_node(name, def)
	local txt = name:gsub(":", "_")
	local tiles = {
		{
			name = txt .. "_" .. def.liquidtype .. "_animated.png",
			backface_culling = false,
			animation = def.animation or {
				type = "vertical_frames",
				aspect_w = def.aspect_w or 16,
				aspect_h = def.aspect_h or 16,
				length = def.length or 2.0,
			},
		},
		{
			name = txt .. "_" .. def.liquidtype .. "_animated.png",
			backface_culling = true,
			animation = def.animation or {
				type = "vertical_frames",
				aspect_w = def.aspect_w or 16,
				aspect_h = def.aspect_h or 16,
				length = def.length or 2.0,
			},
		},
	}

	local special_tiles
	if def.liquidtype == "flowing" then
		special_tiles = tiles
		tiles = {txt .. ".png"}
	end

	minetest.register_node(name .. "_" .. def.liquidtype, {
		description = def.description or txt,
		drawtype = def.liquidtype == "flowing" and "flowingliquid" or "liquid",
		waving = def.waving,
		tiles = def.tiles or tiles,
		special_tiles = def.special_tiles or special_tiles,
		alpha = def.alpha or 176,
		paramtype = "light",
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		is_ground_content = false,
		drop = "",
		drowning = def.drowning or 1,
		light_source = def.light_source,
		liquidtype = def.liquidtype,
		liquid_alternative_flowing = name .. "_flowing",
		liquid_alternative_source = name .. "_source",
		liquid_renewable = def.liquid_renewable or true,
		liquid_viscosity = def.liquid_viscosity or 1,
		damage_per_second = def.damage_per_second,
		post_effect_color = def.post_effekt_color or {a = 103, r = 30, g = 68, 
			b = 90},
		groups = def.groups or {water = 3, liquid = 3, cools_lava = 1},
		sounds = def.sounds or default.node_sound_water_defaults(),
	})
end

function biomes.register_liquid(name, def)
	def.source.liquidtype = "source"
	biomes.register_liquid_node(name, def.source)

	def.flowing.liquidtype = "flowing"
	def.flowing.paramtype2 = "flowingliquid"
	def.flowing.post_effect_color = def.flowing.post_effect_color 
		or def.source.post_effect_color
	biomes.register_liquid_node(name, def.flowing)
end

--
-- Biomes
--

function biomes.define_default(def)
	biomes.sand = def.sand
	biomes.water = def.water
	biomes.lava = def.lava
end

function biomes.register_biome(name, def)
	minetest.register_biome({
		name = name,
		node_dust = def.node_dust,
		node_top = def.node_top,
		depth_top = 1,
		node_filler = def.node_filler,
		depth_filler = def.depth_filler or 3,
		node_stone = def.node_stone,
		node_water_top = def.node_water_top,
		depth_water_top = def.depth_water_top,
		node_river_water = def.node_river_water,
		node_riverbed = def.node_riverbed or "default:sand",
		depth_riverbed = def.depth_riverbed or 2,
		node_dungeon = def.node_dungeon or "default:cobble",
		node_dungeon_alt = def.node_dungeon_alt or "default:mossycobble",
		node_dungeon_stair = def.node_dungeon_stair or "stairs:stair_cobble",
		y_max = def.y_max or 31000,
		y_min = def.y_min or 1,
		heat_point = def.heat_point or 50,
		humidity_point = def.humidity_point or 50
	})
end

function biomes.register_ocean(name, def)
	def.node_top = def.node_top or biomes.sand
	def.node_filler = def.node_filler or biomes.sand
	def.vertical_blend = def.vertical_blend or 1
	def.y_min = def.y_min or -255
	def.node_cave_liquid = def.node_cave_liquid or biomes.water
	biomes.register_biome(name .. "_ocean", def)
end

function biomes.register_under(name, def)
	def.y_max = def.y_max or -256
	def.y_min = def.y_min or -31000
	def.node_cave_liquid = def.node_cave_liquid or {biomes.water, biomes.lava}
	biomes.register_biome(name .. "_under", def)
end

function biomes.register_biome_set(name, def)
	biomes.register_biome(name, def.surface)

	if def.ocean then
		def.ocean.heat_point = def.ocean.heat_point or def.surface.heat_point
		def.ocean.humidity_point = def.ocean.humidity_point or def.surface
			.humidity_point
		biomes.register_ocean(name, def)
	end

	if def.under then
		def.under.heat_point = def.under.heat_point or def.surface.heat_point
		def.under.humidity_point = def.under.humidity_point or def.surface
			.humidity_point
		biomes.register_under(name, def.under)
	end
end

--
-- Ores
--

function biomes.register_stratum(name, def)
	minetest.register_ore({
		ore_type = "stratum",
		ore = name,
		wherein = def.wherein,
		clust_scarcity = def.clust_scarcity or 1,
		y_max = def.y_max or 43,
		y_min = def.y_min or 7,
		noise_params = def.noise_params or {
			offset = def.offset or 25,
			scale = def.scale or 16,
			spread = def.spread or {x = 128, y = 128, z = 128},
			seed = def.seed or 90122,
			octaves = def.octaves or 1,
		},
		stratum_thickness = def.stratum_thickness or 2,
		biomes = def.biomes,
	})
end

