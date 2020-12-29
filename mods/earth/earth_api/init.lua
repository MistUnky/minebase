-- earth_api/init.lua 

earth = {}

function earth.define_default(def)
	earth.stone = def.stone
end

function earth.register_stone(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description or txt,
		tiles = def.tiles or {txt .. ".png"},
		groups = def.groups or {cracky = 3},
		sounds = def.sounds or earth.node_sound_stone_defaults()
	})
end

function earth.register_brick(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "_brick", {
		description = def.description or txt,
		paramtype2 = def.paramtype2 or "facedir",
		place_param2 = def.place_param2 or 0,
		tiles = def.tiles or {txt .. "_brick.png"},
		is_ground_content = def.is_ground_content or false,
		groups = def.groups or {cracky = 2},
		sounds = def.sounds or earth.node_sound_stone_defaults()
	})
end

function earth.register_block(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "_block", {
		description = def.description or txt,
		tiles = def.tiles or {txt .. "_block.png"},
		is_ground_content = def.is_ground_content or false,
		groups = def.groups or {cracky = 2},
		sounds = def.sounds or earth.node_sound_stone_defaults()
	})
end

function earth.register_cobble(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "_cobble", {
		description = def.description or txt,
		tiles = def.tiles or {txt .. "_cobble.png"},
		is_ground_content = def.is_ground_content or false,
		groups = def.groups or {cracky = 3},
		sounds = def.sounds or earth.node_sound_stone_defaults()
	})
end

function earth.register_stone_nodes(name, def)
	if def.cobble then
		def.cobble.groups = def.cobble.groups or {cracky = 3, stone = 2}
		earth.register_cobble(name, def.cobble)
		def.stone.drop = def.stone.drop or name .. "_cobble"

		minetest.register_craft({
			type = "cooking",
			output = name,
			recipe = name .. "_cobble"
		})
	end

	def.stone.groups = def.stone.groups or {cracky = 3, stone = 1}
	earth.register_stone(name, def.stone)

	if def.brick then
		def.brick.groups = def.brick.groups or {cracky = 2, stone = 1},
		earth.register_brick(name, def.brick)
		base_lib.register_craft44(name .. "_brick", name)
	end

	if def.block then
		def.block.groups = def.block.groups or {cracky = 2, stone = 1}
		earth.register_block(name, def.block)
		base_lib.register_craft99(name .. "_block", name)
	end
end

function earth.register_sand(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description or txt,
		tiles = def.tiles or {txt .. ".png"},
		groups = def.groups or {crumbly = 3, falling_node = 1, sand = 1},
		sounds = def.sounds or earth.node_sound_sand_defaults(),
	})
end

function earth.register_ore(name, def)
	minetest.register_ore({
		ore_type = def.type or "blob",
		ore = name,
		wherein = def.wherein or {earth.stone},
		clust_scarcity = def.clust_scarcity or 16 * 16 * 16,
		clust_size = def.clust_size or 5,
		y_max = def.y_max or 31000,
		y_min = def.y_min or -31000,
		noise_threshold = def.noise_threshold or 0.0,
		noise_params = def.noise_params or {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = def.seed or 2316,
			octaves = 1,
			persist = 0.0
		},
		biomes = def.biomes
	})
end

function earth.register_sand_nodes(name, def)
	local namestone = name .. "stone"
	earth.register_sand(name, def.sand)

	if def.stone then
		base_lib.register_craft14(namestone, name)
		def.stone.groups = def.stone.groups or {cracky = 3, crumbly = 1},
		earth.register_stone(namestone, def.stone)

		if def.brick then
			base_lib.register_craft44(namestone .. "_brick 4", namestone)
		end

		if def.block then
			base_lib.register_craft99(namestone .. "_block", namestone)
		end
	end

	if def.brick then
		earth.register_brick(namestone, def.brick)
	end

	if def.block then
		earth.register_block(namestone, def.block)
	end

	if def.ore then
		earth.register_ore(name, def.ore)
	end 
end

function earth.register_node_with(name, def)
	local txt = name:gsub(":", "_")
	local txt_with = string.sub(name, 1, name:find(":") - 1) .. "_" .. def.with
	minetest.register_node(name .. "_with_" .. def.with, {
		description = def.description or txt .. "_with_" .. def.with,
		tiles = def.tiles or {txt_with .. ".png", txt .. ".png",
		{name = txt .. ".png^" .. txt_with .. "_side.png",
			tileable_vertical = false}},
		groups = def.groups or {crumbly = 3, soil = 1, spreading_dirt_type = 1},
		drop = def.drop or name,
		sounds = def.sounds or earth.node_sound_dirt_defaults({
			footstep = {name = "earth_grass_footstep", gain = def.gain or 0.4},
		})
	})
end

function earth.register_nodes_with(name, def)
	if def.base_node then
		def.base_node.tiles = def.base_node.tiles or {name:gsub(":", "_") .. ".png"}
		minetest.register_node(name, def.base_node)
	end

	for _, de in ipairs(def) do
		earth.register_node_with(name, de)
	end
end

--
-- Sounds
--

function earth.node_sound_stone_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "base_sounds_hard_footstep", gain = 0.3}
	table.dug = table.dug or
			{name = "base_sounds_hard_footstep", gain = 1.0}
	base_sounds.node_sound_defaults(table)
	return table
end

function earth.node_sound_dirt_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "earth_api_dirt_footstep", gain = 0.4}
	table.dug = table.dug or
			{name = "earth_api_dirt_footstep", gain = 1.0}
	table.place = table.place or
			{name = "base_sounds_place_node", gain = 1.0}
	base_sounds.node_sound_defaults(table)
	return table
end

function earth.node_sound_sand_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "earth_api_sand_footstep", gain = 0.05}
	table.dug = table.dug or
			{name = "earth_api_sand_footstep", gain = 0.15}
	table.place = table.place or
			{name = "base_sounds_place_node", gain = 1.0}
	base_sounds.node_sound_defaults(table)
	return table
end

function earth.node_sound_gravel_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "earth_api_gravel_footstep", gain = 0.1}
	table.dig = table.dig or
			{name = "earth_api_gravel_dig", gain = 0.35}
	table.dug = table.dug or
			{name = "earth_api_gravel_dug", gain = 1.0}
	table.place = table.place or
			{name = "base_sounds_place_node", gain = 1.0}
	base_sounds.node_sound_defaults(table)
	return table
end

