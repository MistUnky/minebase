-- biomes_api/init.lua

biomes = {}

minetest.clear_registered_biomes()

function biomes.register_sand_node(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description,
		tiles = def.tiles or {txt .. ".png"},
		groups = def.groups or {crumbly = 3, falling_node = 1, sand = 1},
		sounds = default.node_sound_sand_defaults(),
	})
end

function biomes.register_sandstone(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "stone", {
		description = def.description,
		tiles = def.tiles or {txt .. "stone.png"},
		groups = {crumbly = 1, cracky = 3},
		sounds = default.node_sound_stone_defaults(),
	})
end

function biomes.register_sandstone_brick(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "stone_brick", {
		description = def.description,
		paramtype2 = def.paramtype2 or "facedir",
		place_param2 = def.place_param2 or 0,
		tiles = def.tiles or {txt .. "stone_brick.png"},
		is_ground_content = def.is_ground_content or false,
		groups = def.groups or {cracky = 2},
		sounds = default.node_sound_stone_defaults(),
	})
end

function biomes.register_sandstone_block(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "stone_block", {
		description = def.description,
		tiles = def.tiles or {txt .. "stone_block.png"},
		is_ground_content = def.is_ground_content or false,
		groups = def.groups or {cracky = 2},
		sounds = default.node_sound_stone_defaults(),
	})
end

function biomes.register_sand(name, def)
	biomes.register_sand_node(name, def.sand_node)
	
	if def.sandstone then
		biomes.register_sandstone(name, def.sandstone)
	end

	if def.sandstone_brick then
		biomes.register_sandstone_brick(name, def.sandstone_brick)
	end

	if def.sandstone_block then
		biomes.register_sandstone_block(name, def.sandstone_block)
	end
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
	def.node_top = def.node_top or "base_biomes:sand"
	def.node_filler = def.node_filler or "base_biomes:sand"
	def.vertical_blend = def.vertical_blend or 1
	def.y_min = def.y_min or -255
	def.node_cave_liquid = def.node_cave_liquid or "base_biomes:water_source"
	biomes.register_biome(name .. "_ocean", def)
end

function biomes.register_under(name, def)
	def.y_max = def.y_max or -256
	def.y_min = def.y_min or -31000
	def.node_cave_liquid = def.node_cave_liquid or {"base_biomes:water_source", 
		"base_biomes:lava_source"}
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
