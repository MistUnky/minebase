-- flowers_api/init.lua

-- Namespace for functions

flowers = {}
local mapgen = {}

function mapgen.register_flower(flower_name, seed)
	minetest.register_decoration({
		name = flower_name,
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.04,
			spread = {x = 200, y = 200, z = 200},
			seed = seed,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"grassland", "deciduous_forest"},
		y_max = 31000,
		y_min = 1,
		decoration = flower_name,
	})
end

function mapgen.register_mushroom(mushroom_name)
	minetest.register_decoration({
		name = mushroom_name,
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_coniferous_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.006,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest", "coniferous_forest"},
		y_max = 31000,
		y_min = 1,
		decoration = mushroom_name,
	})
end

function mapgen.register_waterlily(name)
	minetest.register_decoration({
		name = name,
		deco_type = "simple",
		place_on = {"default:dirt"},
		sidelen = 16,
		noise_params = {
			offset = -0.12,
			scale = 0.3,
			spread = {x = 200, y = 200, z = 200},
			seed = 33,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"rainforest_swamp", "savanna_shore", "deciduous_forest_shore"},
		y_max = 0,
		y_min = 0,
		decoration = name.."_waving",
		param2 = 0,
		param2_max = 3,
		place_offset_y = 1,
	})
end

--
-- Flowers
--

-- Flower registration

function flowers.register_flower(name, def)
	-- Common flowers' groups
	def.groups.snappy = 3
	def.groups.flower = 1
	def.groups.flora = 1
	def.groups.attached_node = 1

	minetest.register_node(name, {
		description = def.desc,
		drawtype = "plantlike",
		waving = 1,
		tiles = { def.image },
		inventory_image = def.image,
		wield_image = def.image,
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		groups = def.groups,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = def.box_size
		}
	})

	mapgen.register_flower(name,def.seed)
end

-- Flower spread
-- Public function to enable override by mods

function flowers.flower_spread(pos, node)
	pos.y = pos.y - 1
	local under = minetest.get_node(pos)
	pos.y = pos.y + 1
	-- Replace flora with dry shrub in desert sand and silver sand,
	-- as this is the only way to generate them.
	-- However, preserve grasses in sand dune biomes.
	if minetest.get_item_group(under.name, "sand") == 1 and
			under.name ~= "default:sand" then
		minetest.set_node(pos, {name = "default:dry_shrub"})
		return
	end

	if minetest.get_item_group(under.name, "soil") == 0 then
		return
	end

	local light = minetest.get_node_light(pos)
	if not light or light < 13 then
		return
	end

	local pos0 = vector.subtract(pos, 4)
	local pos1 = vector.add(pos, 4)
	-- Testing shows that a threshold of 3 results in an appropriate maximum
	-- density of approximately 7 flora per 9x9 area.
	if #minetest.find_nodes_in_area(pos0, pos1, "group:flora") > 3 then
		return
	end

	local soils = minetest.find_nodes_in_area_under_air(
		pos0, pos1, "group:soil")
	local num_soils = #soils
	if num_soils >= 1 then
		for si = 1, math.min(3, num_soils) do
			local soil = soils[math.random(num_soils)]
			local soil_name = minetest.get_node(soil).name
			local soil_above = {x = soil.x, y = soil.y + 1, z = soil.z}
			light = minetest.get_node_light(soil_above)
			if light and light >= 13 and
					-- Only spread to same surface node
					soil_name == under.name and
					-- Desert sand is in the soil group
					soil_name ~= "default:desert_sand" then
				minetest.set_node(soil_above, {name = node.name})
			end
		end
	end
end

minetest.register_abm({
	label = "Flower spread",
	nodenames = {"group:flora"},
	interval = 13,
	chance = 300,
	action = function(...)
		flowers.flower_spread(...)
	end,
})

-- Mushroom spread and death

function flowers.register_mushroom(name, def)
	minetest.register_node(name, {
		description = def.desc,
		tiles = { def.image },
		inventory_image = def.image,
		wield_image = def.image,
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = def.groups,
		sounds = default.node_sound_leaves_defaults(),
		on_use = def.on_use,
		selection_box = {
			type = "fixed",
			fixed = def.box_size
		}
	})

	mapgen.register_mushroom(name)
end

function flowers.mushroom_spread(pos, node)
	if minetest.get_node_light(pos, 0.5) > 3 then
		if minetest.get_node_light(pos, nil) == 15 then
			minetest.remove_node(pos)
		end
		return
	end
	local positions = minetest.find_nodes_in_area_under_air(
		{x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
		{x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
		{"group:soil", "group:tree"})
	if #positions == 0 then
		return
	end
	local pos2 = positions[math.random(#positions)]
	pos2.y = pos2.y + 1
	if minetest.get_node_light(pos2, 0.5) <= 3 then
		minetest.set_node(pos2, {name = node.name})
	end
end

minetest.register_abm({
	label = "Mushroom spread",
	nodenames = {"flowers:mushroom_brown", "flowers:mushroom_red"},
	interval = 11,
	chance = 150,
	action = function(...)
		flowers.mushroom_spread(...)
	end,
})

function flowers.register_waterlily(name, def)
	local water_lily = {
		description = def.desc,
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		tiles = def.tiles,
		inventory_image = def.tiles[1],
		wield_image = def.tiles[1],
		liquids_pointable = true,
		walkable = false,
		buildable_to = true,
		floodable = true,
		groups = def.groups,
		sounds = default.node_sound_leaves_defaults(),
		node_placement_prediction = "",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -31 / 64, -0.5, 0.5, -15 / 32, 0.5}
		},
		selection_box = {
			type = "fixed",
			fixed = def.box_size
		},

		on_place = function(itemstack, placer, pointed_thing)
			local pos = pointed_thing.above
			local node = minetest.get_node(pointed_thing.under)
			local def = minetest.registered_nodes[node.name]

			if def and def.on_rightclick then
				return def.on_rightclick(pointed_thing.under, node, placer, itemstack,
						pointed_thing)
			end

			if def and def.liquidtype == "source" and
					minetest.get_item_group(node.name, "water") > 0 then
				local player_name = placer and placer:get_player_name() or ""
				if not minetest.is_protected(pos, player_name) then
					minetest.set_node(pos, {name = name ..
						(def.waving == 3 and "_waving" or ""),
						param2 = math.random(0, 3)})
					if not (creative and creative.is_enabled_for
							and creative.is_enabled_for(player_name)) then
						itemstack:take_item()
					end
				else
					minetest.chat_send_player(player_name, "Node is protected")
					minetest.record_protection_violation(pos, player_name)
				end
			end

			return itemstack
		end
	}

	local water_lily_waving = table.copy(water_lily)
	water_lily_waving.waving = 3
	water_lily_waving.drop = name
	water_lily_waving.groups.not_in_creative_inventory = 1

	minetest.register_node(name, water_lily)
	minetest.register_node(name .. "_waving", water_lily_waving)

	mapgen.register_waterlily(name)
end