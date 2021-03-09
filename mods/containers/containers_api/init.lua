-- containers_api/init.lua

-- support for Minebase translation.
local S = minetest.get_translator("containers_api")

containers = {}
containers.open_containers = {}
containers.form = {}

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if not containers.form[formname] then
		return
	end

	if not player or not fields.quit then
		return
	end

	local pn = player:get_player_name()
	if containers.open_containers[pn] then
		containers.close(pn)
		return true
	end
end)

minetest.register_on_leaveplayer(function(player)
	local pn = player:get_player_name()
	if containers.open_containers[pn] then
		return containers.close(pn)
	end
end)

function containers.create_formspec(inventory1, def)
	inventory1 = inventory1 or "context"
	if def then
		return table.concat({
			"size[", def.width or 8, ",", def.height or 9, "]",
			"list[", inventory1, ";", def.list1 or "main", ";", 
				def.x1 or 0, ",", def.y1 or 0.3, ";", 
				def.inventory1_width or 8, ",", def.inventory1_height or 4,";]",
			"list[current_player;main;", 
				def.x2 or 0, ",", def.y2 or 4.85, ";", 
				"8,1;]",
			"list[current_player;main;",
				def.x2 or 0, ",", def.y2 and def.y2 + 1.23 or 6.08, ";",
				"8,3;8]",
			"listring[", inventory1, ";", def.list1 or "main", "]",
			"listring[current_player;main]",
			formspecs.get_hotbar_bg(def.x2 or 0, def.y2 or 4.85),
			def.overlay or ""
		})
	else
		return table.concat({
			"size[8,9]\z
			list[", inventory1, ";main;0,0.3;8,4;]\z
			list[current_player;main;0,4.85;8,1;]\z
			list[current_player;main;0,6.08;8,3;8]\z
			listring[", inventory1, ";main]\z
			listring[current_player;main]",
			formspecs.get_hotbar_bg(0, 4.85)
		})
	end
end

function containers.lid_obstructed(pos)
	local def = minetest.registered_nodes[minetest.get_node(pos).name]
	-- allow ladders, signs, wallmounted things and torches to not obstruct
	return not (def and
			(def.drawtype == "airlike" or
			def.drawtype == "signlike" or
			def.drawtype == "torchlike" or
			(def.drawtype == "nodebox" and def.paramtype2 == "wallmounted")))
end

function containers.close(name)
	local container_open_info = containers.open_containers[name]
	local pos = container_open_info.pos
	local sound = container_open_info.sound
	local node_closed = container_open_info.node_closed
	
	containers.open_containers[name] = nil
	for k, v in pairs(containers.open_containers) do
		if v.pos.x == pos.x and v.pos.y == pos.y and v.pos.z == pos.z then
			return true
		end
	end

	if node_closed then
		local node = minetest.get_node(pos)
		minetest.after(0.2, minetest.swap_node, pos, { name = node_closed,
				param2 = node.param2 })
	end
	minetest.sound_play(sound, {gain = 0.3, pos = pos,
		max_hear_distance = 10}, true)
end

containers.unprotected = {}
function containers.unprotected.on_construct(pos)
	local meta = minetest.get_meta(pos)
	local node_def = minetest.registered_nodes[minetest.get_node(pos).name]
	meta:set_string("infotext", node_def.description)
	local inv = meta:get_inventory()
	inv:set_size(node_def._formspec_def and node_def._formspec_def.list1 or "main", 
		node_def._inventory_width * node_def._inventory_height)
	if node_def._update then
		node_def._update(pos)
	end
end

function containers.unprotected.can_dig(pos,player)
	local node_def = minetest.registered_nodes[minetest.get_node(pos).name]
	return minetest.get_meta(pos):get_inventory():is_empty(node_def._formspec_def
		and node_def._formspec_def.list1 or "main")
end

local function determine_opening_pos(tmp, pos)
	local out = table.copy(pos)
	tmp = tmp._opening_side
	if tmp == "+y" then
		out.y = out.y + 1
	elseif tmp == "+x" then
		out.x = out.x + 1
	elseif tmp == "-x" then
		out.x = out.x - 1
	elseif tmp == "+z" then
		out.z = out.z + 1
	elseif tmp == "-z" then
		out.z = out.z - 1
	elseif tmp == "-y" then
		out.y = out.y - 1
	end
	return out
end

function containers.unprotected.on_rightclick(pos, node, clicker, itemstack)
	local node_def = minetest.registered_nodes[node.name]
	minetest.sound_play(node_def._sound, {gain = 0.3, pos = pos,
			max_hear_distance = 10}, true)
	if node_def._node_opened and not containers.lid_obstructed(
		determine_opening_pos(node_def, pos)) then
		minetest.swap_node(pos, {name = node_def._node_opened, param2 = node.param2})
	end
	minetest.after(0.2, minetest.show_formspec, clicker:get_player_name(),
		node_def._node_closed or node.name, containers.create_formspec("nodemeta:" 
		.. pos.x .. "," .. pos.y .. "," .. pos.z, node_def._formspec_def))
	containers.open_containers[clicker:get_player_name()] = {pos = pos,
			sound = node_def._sound, node_closed = node_def._node_closed}
end

function containers.unprotected.on_blast(pos)
	local drops = {}
	local name = minetest.get_node(pos).name
	local node_def = minetest.registered_nodes[name]
	inv_utils.get_inventory_drops(pos, node_def._formspec_def.list1 or "main", 
		drops)
	drops[#drops+1] = name
	minetest.remove_node(pos)
	return drops
end

function containers.unprotected.allow_metadata_inventory_put(pos, _, _, stack)
	local node_def = minetest.registered_nodes[minetest.get_node(pos).name]
	if node_def._allowed_item_group then
		if minetest.get_item_group(stack:get_name(), node_def._allowed_item_group) 
			~= 0 then
			return stack:get_count()
		end
	else
		return stack:get_count()
	end
	return 0
end

containers.protected = {}
function containers.protected.on_construct(pos)
	local meta = minetest.get_meta(pos)
	local node_def = minetest.registered_nodes[minetest.get_node(pos).name]
	meta:set_string("infotext", node_def.description)
	meta:set_string("owner", "")
	local inv = meta:get_inventory()
	inv:set_size(node_def._formspec_def and node_def._formspec_def.list1 or "main", 
		node_def._inventory_width * node_def._inventory_height)
	if node_def._update then
		node_def._update(pos)
	end
end

function containers.protected.after_place_node(pos, placer)
	local meta = minetest.get_meta(pos)
	meta:set_string("owner", placer:get_player_name() or "")
	meta:set_string("infotext", minetest.registered_nodes
		[minetest.get_node(pos).name].description .. " ".. S("(owned by @1)", 
		meta:get_string("owner")))
end

function containers.protected.can_dig(pos, player)
	local node_def = minetest.registered_nodes[minetest.get_node(pos).name]
	return minetest.get_meta(pos):get_inventory():is_empty(node_def._formspec_def
		and node_def._formspec_def.list1 or "main") and permissions
			.can_interact_with_node(player, pos)
end

function containers.protected.on_rightclick(pos, node, clicker, itemstack)
	if not permissions.can_interact_with_node(clicker, pos) then
		return itemstack
	end
	local node_def = minetest.registered_nodes[node.name]

	minetest.sound_play(node_def._sound, {gain = 0.3,
			pos = pos, max_hear_distance = 10}, true)
	if node_def._node_opened and not containers.lid_obstructed(
		determine_opening_pos(node_def, pos)) then
		minetest.swap_node(pos, {name = node_def._node_opened,param2 = node.param2})
	end
	minetest.after(0.2, minetest.show_formspec, clicker:get_player_name(),
		node_def._node_closed or node.name, containers.create_formspec("nodemeta:" 
		.. pos.x .. "," .. pos.y .. "," .. pos.z, node_def._formspec_def))
	containers.open_containers[clicker:get_player_name()] = {pos = pos,
			sound = node_def._sound, node_closed = node_def._node_closed}
end

function containers.protected.on_blast() end

function containers.protected.allow_metadata_inventory_move(pos, _, _, _ , _, 
	count, player)
	if not permissions.can_interact_with_node(player, pos) then
		return 0
	end
	return count
end

function containers.protected.allow_metadata_inventory_put(pos, _, _, stack, 
	player)
	if permissions.can_interact_with_node(player, pos) then
		local node_def = minetest.registered_nodes[minetest.get_node(pos).name]
		if node_def._allowed_item_group then
			if minetest.get_item_group(stack:get_name(), node_def._allowed_item_group) 
				~= 0 then
				return stack:get_count()
			end
		else
			return stack:get_count()
		end
	end
	return 0
end

function containers.protected.allow_metadata_inventory_take(pos, _, _, stack, 
	player)
	if not permissions.can_interact_with_node(player, pos) then
		return 0
	end
	return stack:get_count()
end

function containers.protected.on_key_use(pos, player)
	local secret = minetest.get_meta(pos):get_string("key_lock_secret")
	local itemstack = player:get_wielded_item()
	local key_meta = itemstack:get_meta()

	if itemstack:get_metadata() == "" then
		return
	end

	if key_meta:get_string("secret") == "" then
		key_meta:set_string("secret", minetest.parse_json(itemstack:get_metadata())
			.secret)
		itemstack:set_metadata("")
	end

	if secret ~= key_meta:get_string("secret") then
		return
	end

	minetest.show_formspec(player:get_player_name(), minetest.registered_nodes
		[minetest.get_node(pos).name]._node_closed or node.name,
		containers.create_formspec("nodemeta:" .. pos.x .. "," .. pos.y 
		.. "," .. pos.z, node_def._formspec_def))
end

function containers.protected.on_skeleton_key_use(pos, player, newsecret)
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")
	local pn = player:get_player_name()

	-- verify placer is owner of lockable container
	if owner ~= pn then
		minetest.record_protection_violation(pos, pn)
		minetest.chat_send_player(pn, minetest.registered_nodes
			[minetest.get_node(pos).name].description .. " ".. S("(owned by @1)", 
			meta:get_string("owner")))
		return nil
	end

	local secret = meta:get_string("key_lock_secret")
	if secret == "" then
		secret = newsecret
		meta:set_string("key_lock_secret", secret)
	end

	return secret, S("a locked container"), owner
end

function containers.on_metadata_inventory_move(pos, _, _, _, _, _, player)
	local node_def = minetest.registered_nodes[minetest.get_node(pos).name]
	if node_def._update then
		node_def._update(pos)
	end
end

function containers.on_metadata_inventory_put(pos, _, _, stack, player)
	local node_def = minetest.registered_nodes[minetest.get_node(pos).name]
	if node_def._update then
		node_def._update(pos)
	end
end

function containers.on_metadata_inventory_take(pos, _, _, stack, player)
	local node_def = minetest.registered_nodes[minetest.get_node(pos).name]
	if node_def._update then
		node_def._update(pos)
	end
end

local function register_container(name, def)
	local txt = name:gsub(":", "_")
	local callbacks_p = def.protected and containers.protected or 
		containers.unprotected

	local tiles
	if def.tiles then
		tiles = table.copy(def.tiles)
		tiles[3] = tiles[3] .. "^[transformFX"
	else
		tiles = {txt .. "_top.png", txt .. "_bottom.png",
			txt .. "_side.png^[transformFX", txt .. "_side.png", txt .. "_back.png",
			txt .. "_front.png",
		}
	end

	minetest.register_node(name, {
		description = def.description or txt,
		drawtype = def.drawtype,
		visual = def.visual,
		mesh = def.mesh,
		tiles = tiles,
		groups = def.groups or {choppy = 2, oddly_breakable_by_hand = 2},
		drop = def.drop,
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = def.selection_box,
		legacy_facedir_simple = true,
		is_ground_content = false,
		sounds = def.sounds or sounds.get_defaults("tree_sounds:wood"),
		can_dig = def.can_dig or callbacks_p.can_dig,
		on_blast = def.on_blast or callbacks_p.on_blast,
		on_construct = def.on_construct or callbacks_p.on_construct,
		after_place_node = callbacks_p.after_place_node,
		on_rightclick = def.on_rightclick or callbacks_p.on_rightclick,
		allow_metadata_inventory_move = def.allow_metadata_inventory_move
			or callbacks_p.allow_metadata_inventory_move,
		allow_metadata_inventory_put = def.allow_metadata_inventory_put 
			or callbacks_p.allow_metadata_inventory_put,
		allow_metadata_inventory_take = def.allow_metadata_inventory_take 
			or callbacks_p.allow_metadata_inventory_take,
		on_metadata_inventory_move = def.on_metadata_inventory_move 
			or containers.on_metadata_inventory_move,
		on_metadata_inventory_put = def.on_metadata_inventory_put 
			or containers.on_metadata_inventory_put,
		on_metadata_inventory_take = def.on_metadata_inventory_take 
			or containers.on_metadata_inventory_take,
		on_key_use = def.on_key_use or callbacks_p.on_key_use,
		on_skeleton_key_use = def.on_skeleton_key_use 
			or callbacks_p.on_skeleton_key_use,
		on_punch = def.on_punch,
		on_timer = def.on_timer,
		_inventory_width = def.inventory_width or 8,
		_inventory_height = def.inventory_height or 4,
		_allowed_item_group = def.allowed_item_group,
		_sound = def.sound or txt .. "_open",
		_formspec_def = def.formspec_def,
		_update = def.update,
		_node_opened = def.node_opened,
		_node_closed = def.node_opened and name,
		_opening_side = def.opening_side or "+y",
	})

	if def.recipe then
		minetest.register_craft({
			output = name,
			recipe = def.recipe
		})
	end

	if def.burntime then
		minetest.register_craft({
			type = "fuel",
			recipe = name,
			burntime = def.burntime,
		})
	end
end

local open = {}
function open.can_dig() return false end
function open.on_blast() end

local function register_container_opened(name, def)
	local txt = name:gsub(":", "_")
	local callbacks_p = def.protected and containers.protected or 
		containers.unprotected

	local groups
	if def.groups then
		groups = table.copy(def.groups)
		groups.not_in_creative_inventory = 1
	else
		groups = {not_in_creative_inventory = 1}
	end

	local tiles
	if def.tiles then
		tiles = table.copy(def.tiles)
		tiles[3] = tiles[4] 
		tiles[5] = tiles[6]
		tiles[6] = def.inside
	else
		tiles = {txt .. "_top.png", txt .. "_bottom.png", txt .. "_side.png", 
			txt .. "_side.png", txt .. "_front.png", txt .. "_inside.png"
		}
	end

	minetest.register_node(name .. "_opened", {
		description = def.description or txt,
		drawtype = def.drawtype or "mesh",
		visual = def.visual or "mesh",
		mesh = def.mesh or "containers_chest_open.obj",
		tiles = tiles,
		groups = groups,
		drop = name,
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = def.selection_box or {
			type = "fixed",
			fixed = { -1/2, -1/2, -1/2, 1/2, 3/16, 1/2 },
		},
		legacy_facedir_simple = true,
		is_ground_content = false,
		sounds = def.sounds or sounds.get_defaults("tree_sounds:wood"),
		can_dig = open.can_dig,
		on_blast = open.on_blast,
		on_construct = def.on_construct or callbacks_p.on_construct,
		after_place_node = callbacks_p.after_place_node,
		on_rightclick = def.on_rightclick or callbacks_p.on_rightclick,
		allow_metadata_inventory_move = def.allow_metadata_inventory_move
			or callbacks_p.allow_metadata_inventory_move,
		allow_metadata_inventory_put = def.allow_metadata_inventory_put 
			or callbacks_p.allow_metadata_inventory_put,
		allow_metadata_inventory_take = def.allow_metadata_inventory_take 
			or callbacks_p.allow_metadata_inventory_take,
		on_metadata_inventory_move = def.on_metadata_inventory_move 
			or containers.on_metadata_inventory_move,
		on_metadata_inventory_put = def.on_metadata_inventory_put 
			or containers.on_metadata_inventory_put,
		on_metadata_inventory_take = def.on_metadata_inventory_take 
			or containers.on_metadata_inventory_take,
		on_key_use = def.on_key_use or callbacks_p.on_key_use,
		on_skeleton_key_use = def.on_skeleton_key_use 
			or callbacks_p.on_skeleton_key_use,
		_sound = def.sound or txt .. "_open",
		_node_closed = name,
	})
end

function containers.register_container(name, def)
	if def.opened then
		def.closed.node_opened = name .. "_opened"
	end
	register_container(name, def.closed)

	if def.opened then
		def.opened.tiles = def.opened.tiles or def.closed.tiles
		def.opened.protected = def.opened.protected or def.closed.protected
		register_container_opened(name, def.opened)
	end
	containers.form[name] = true
end

