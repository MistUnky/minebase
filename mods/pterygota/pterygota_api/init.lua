-- pterygota_api/init.lua

pterygota = {threshold = 11, decos = {}}

function pterygota.on_place(itemstack, placer, pointed_thing)
	local player_name = placer:get_player_name()
	local pos = pointed_thing.above

	if not minetest.is_protected(pos, player_name) and
			not minetest.is_protected(pointed_thing.under, player_name) and
			minetest.get_node(pos).name == "air" then

		minetest.set_node(pos, {name = itemstack:get_name()})
		minetest.get_node_timer(pos):start(1)
		itemstack:take_item()
	end
	return itemstack
end

function pterygota.on_timer_dark(pos)
	if minetest.get_node_light(pos) <= pterygota.threshold then
		minetest.set_node(pos, {name = minetest.registered_nodes
			[minetest.get_node(pos).name].swap})
	end
	minetest.get_node_timer(pos):start(30)
end

function pterygota.on_timer_bright(pos)
	if minetest.get_node_light(pos) > pterygota.threshold then
		minetest.set_node(pos, {name = minetest.registered_nodes
			[minetest.get_node(pos).name].swap})
	end
	minetest.get_node_timer(pos):start(30)
end

function pterygota.register_deco(name, def)
	minetest.register_decoration({
		name = name,
		deco_type = "simple",
		place_on = def.place_on,
		place_offset_y = def.place_offset_y or 2,
		sidelen = def.sidelen or 80,
		fill_ratio = def.fill_ratio or 0.005,
		biomes = def.biomes,
		y_max = def.y_max or 31000,
		y_min = def.y_min or 1,
		decoration = def.decoration or name,
		spawn_by = def.spawn_by,
		num_spawn_by = def.num_spawn_by
	})
	local id = minetest.get_decoration_id(name)
	minetest.set_gen_notify({decoration = true}, {id})
	pterygota.decos[id] = (def.place_offset_y or 2) + 1
end

function pterygota.register_visible(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description or txt,
		drawtype = "plantlike",
		tiles = def.tiles or {{
			name = txt .. "_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = def.length or 3
			},
		}},
		inventory_image = def.inventory_image or txt .. ".png",
		wield_image = def.wield_image or txt ..  ".png",
		waving = def.waving or 1,
		paramtype = "light",
		sunlight_propagates = def.sunlight_propagates or true,
		buildable_to = def.buildable_to or true,
		walkable = def.walkable or false,
		pointable = def.pointable or false,
		groups = def.groups or {catchable = 1},
		selection_box = def.selection_box or {
			type = "fixed",
			fixed = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
		},
		light_source = def.light_source,
		floodable = true,
		on_place = def.on_place or pterygota.on_place,
		on_timer = def.on_timer or pterygota.on_timer_dark,
		swap = name .. "_hidden",
		sounds = def.sounds,
		drop = def.drop,
		on_secondary_use = def.on_secondary_use,
		on_drop = def.on_drop,
		on_use = def.on_use,
		after_use = def.after_use,
		on_flood = def.on_flood,
		on_rightclick = def.on_rightclick,
		on_dig = def.on_dig,
		on_punch = def.on_punch
	})

	if def.deco then
		pterygota.register_deco(name, def.deco)
	end
end

function pterygota.register_hidden(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "_hidden", {
		description = def.description or txt,
		drawtype = "airlike",
		inventory_image = def.inventory_image or txt .. ".png",
		wield_image =  def.wield_image or txt .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		drop = "",
		groups = {not_in_creative_inventory = 1},
		floodable = true,
		on_place = def.on_place or pterygota.on_place,
		on_timer = def.on_timer or pterygota.on_timer_bright,
		swap = name,
		on_flood = def.on_flood,
	})

	if def.deco then
		pterygota.register_deco(name .. "_hidden", def.deco)
	end
end

function pterygota.register_pterygota(name, def)
	pterygota.register_visible(name, def.visible)

	if def.hidden then
		pterygota.register_hidden(name, def.hidden)
	end
end

-- start nodetimers
minetest.register_on_generated(function()
	local gennotify = minetest.get_mapgen_object("gennotify")

	for id, offset in pairs(pterygota.decos) do
		for _, pos in ipairs(gennotify["decoration#" .. id] or {}) do
			minetest.get_node_timer({x = pos.x, y = pos.y + offset, z = pos.z})
				:start(1)
		end
	end
end)
