-- hydrophytes_api/init.lua

hydrophytes = {}

function hydrophytes.on_place(itemstack, placer, pointed_thing, root, max)
	if pointed_thing.type ~= "node" or not placer then
		return itemstack
	end

	local pos_under = pointed_thing.under
	local node_under = minetest.get_node(pos_under)
	local def_under = minetest.registered_nodes[node_under.name]

	if def_under and def_under.on_rightclick and not placer:get_player_control().sneak then
		return def_under.on_rightclick(pos_under, node_under, placer, itemstack, 
			pointed_thing) or itemstack
	end

	if node_under.name ~= root then
		return itemstack
	end
	
	local height = max and math.random(max[1], max[2]) or 1
	local pos_top = {x = pos_under.x, y = pos_under.y + height, z = pos_under.z}
	local node_top = minetest.get_node(pos_top)
	local def_top = minetest.registered_nodes[node_top.name]
	local player_name = placer:get_player_name()

	if minetest.is_protected(pos_under, player_name) then
		minetest.record_protection_violation(pos_under, player_name)
		return itemstack
	end

	local tmp
	for fi = 1, height do
		tmp = {x = pos_under.x, y = pos_under.y + fi, z = pos_under.z}
		if minetest.is_protected(tmp, player_name) then
			minetest.record_protection_violation(tmp, player_name)
			return itemstack
		end
		tmp = minetest.get_node(tmp)
		if not tmp or minetest.registered_nodes[tmp.name].liquidtype 
			~= "source" then
			return itemstack
		end
	end

	minetest.set_node(pos_under, {name = itemstack:get_name(), param2 = height * 16})

	if not minetest.is_creative_enabled(player_name) then
		itemstack:take_item()
	end

	return itemstack
end

function hydrophytes.after_destruct(pos, _, root)
	minetest.set_node(pos, {name = root})
end

function hydrophytes.register_phyte(name, def)
	local txt = name:gsub(":", "_")
	local rootTxt = def.root:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description or txt,
		drawtype = "plantlike_rooted",
		waving = def.waving or 1,
		paramtype = "light",
		paramtype2 = def.paramtype2,
		tiles = def.tiles or {rootTxt .. ".png"},
		special_tiles = def.special_tiles or {{name = txt .. ".png", 
			tileable_vertical = true}},
		inventory_image = def.inventory_image or txt .. ".png",
		groups = def.groups or {snappy = 3},
		selection_box = def.selection_box or {
			type = "fixed",
			fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
					{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
			},
		},
		node_dig_prediction = def.node_dig_prediction or def.root,
		node_placement_prediction = def.node_placement_prediction or "",
		sounds = def.sounds or earth.node_sound_stone_defaults({
			dig = {name = "base_sounds_dig_snappy", gain = 0.2},
			dug = {name = "base_earth_grass_footstep", gain = 0.25},
		}),

		on_place = def.on_place or function(itemstack, placer, pointed_thing)
			return hydrophytes.on_place(itemstack, placer, pointed_thing, 
				def.root, def.max)
		end,

		after_destruct = def.after_destruct or function(pos)
			return hydrophytes.after_destruct(pos, nil, def.root)
		end,
	})
end

function hydrophytes.register_coral(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description or txt,
		tiles = def.tiles or {txt .. ".png"},
		groups = def.groups or {cracky = 3},
		drop = def.drop,
		sounds = def.sounds or earth.node_sound_stone_defaults(),
	})
end
