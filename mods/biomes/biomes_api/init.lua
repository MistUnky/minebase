-- biomes_api/init.lua

biomes = {}

minetest.clear_registered_biomes()

function biomes.define_default(def)
	biomes.sand = def.sand
	biomes.stone_cobble = def.stone_cobble
	biomes.mossy_stone_cobble = def.mossy_stone_cobble
	biomes.water = def.water
	biomes.lava = def.lava
end

--
-- Biomes
--

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
		node_riverbed = def.node_riverbed or biomes.sand,
		depth_riverbed = def.depth_riverbed or 2,
		node_dungeon = def.node_dungeon or biomes.stone_cobble,
		node_dungeon_alt = def.node_dungeon_alt or biomes.mossy_stone_cobble,
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

