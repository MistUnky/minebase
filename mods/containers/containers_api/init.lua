-- containers_api/init.lua

-- support for Minebase translation.
local S = minetest.get_translator("containers_api")

containers = {}
containers.open_containers = {}


function containers.get_inventory_drops(pos, inventory, drops)
	local inv = minetest.get_meta(pos):get_inventory()
	local n = #drops
	for i = 1, inv:get_size(inventory) do
		local stack = inv:get_stack(inventory, i)
		if stack:get_count() > 0 then
			drops[n+1] = stack:to_table()
			n = n + 1
		end
	end
end

local empty = {}
function containers.create_formspec(name, def)
	def = def or empty

	return table.concat({
		"size[", def.width or 8, ",", def.height or 9, "]",
		"list[", name, ";", def.list1 or "main", ";", 
			def.x1 or 0, ",", def.y1 or 0.3, ";", 
			def.inventory1_width or 8, ",", def.inventory1_height or 4,";]",
		"list[current_player;main;", 
			def.x2 or 0, ",", def.y2 or 4.85, ";", 
			"8,1;]",
		"list[current_player;main;",
			def.x2 or 0, ",", def.y2 and def.y2 + 1.23 or 6.08, ";",
			"8,3;8]",
		"listring[", name, ";", def.list1 or "main", "]",
		"listring[current_player;main]",
		default.get_hotbar_bg(def.x2 or 0, def.y2 or 4.85)
	})
end

function containers.lid_obstructed(pos)
	local above = {x = pos.x, y = pos.y + 1, z = pos.z}
	local def = minetest.registered_nodes[minetest.get_node(above).name]
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
	local swap = container_open_info.swap

	containers.open_containers[name] = nil
	for k, v in pairs(containers.open_containers) do
		if v.pos.x == pos.x and v.pos.y == pos.y and v.pos.z == pos.z then
			return true
		end
	end

	local node = minetest.get_node(pos)
	minetest.after(0.2, minetest.swap_node, pos, { name = swap,
			param2 = node.param2 })
	minetest.sound_play(sound, {gain = 0.3, pos = pos,
		max_hear_distance = 10}, true)
end

containers.unprotected = {}
function containers.unprotected.on_construct(pos)
	local meta = minetest.get_meta(pos)
	local node_def = minetest.registered_nodes[minetest.get_node(pos).name]
	meta:set_string("infotext", node_def.description)
	local inv = meta:get_inventory()
	inv:set_size("main", node_def.inventory_width * node_def.inventory_height)
end

function containers.unprotected.can_dig(pos,player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	return inv:is_empty("main")
end

function containers.unprotected.on_rightclick(pos, node, clicker, itemstack)
	local node_def = minetest.registered_nodes[node.name]
	minetest.sound_play(node_def.sound_open, {gain = 0.3, pos = pos,
			max_hear_distance = 10}, true)
	if not containers.lid_obstructed(pos) then
		minetest.swap_node(pos, {
				name = node.name .. "_opened",
				param2 = node.param2 })
	end
	minetest.after(0.2, minetest.show_formspec, clicker:get_player_name(),
		node_def.name, containers.create_formspec("nodemeta:" .. pos.x .. "," 
		.. pos.y .. "," .. pos.z))
	containers.open_containers[clicker:get_player_name()] = { pos = pos,
			sound = node_def.sound_close, swap = node.name }
end

function containers.unprotected.on_blast(pos)
	local drops = {}
	containers.get_inventory_drops(pos, "main", drops)
	drops[#drops+1] = name
	minetest.remove_node(pos)
	return drops
end

containers.protected = {}
function containers.protected.on_construct(pos)
	local meta = minetest.get_meta(pos)
	local node_def = minetest.registered_nodes[minetest.get_node(pos).name]
	meta:set_string("infotext", node_def.description)
	meta:set_string("owner", "")
	local inv = meta:get_inventory()
	inv:set_size("main", node_def.inventory_width * node_def.inventory_height)
end

function containers.protected.after_place_node(pos, placer)
	local meta = minetest.get_meta(pos)
	meta:set_string("owner", placer:get_player_name() or "")
	meta:set_string("infotext", minetest.registered_nodes
		[minetest.get_node(pos).name].description .. " ".. S("(owned by @1)", 
		meta:get_string("owner")))
end

function containers.protected.can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("main") and
			default.can_interact_with_node(player, pos)
end

function containers.protected.on_rightclick(pos, node, clicker, itemstack)
	if not default.can_interact_with_node(clicker, pos) then
		return itemstack
	end
	local node_def = minetest.registered_nodes[node.name]

	minetest.sound_play(node_def.sound_open, {gain = 0.3,
			pos = pos, max_hear_distance = 10}, true)
	if not containers.lid_obstructed(pos) then
		minetest.swap_node(pos,
				{ name = node.name .. "_opened",
				param2 = node.param2 })
	end
	minetest.after(0.2, minetest.show_formspec, clicker:get_player_name(),
		node.name, containers.create_formspec("nodemeta:" .. pos.x .. "," .. pos.y 
		.. "," .. pos.z))
	containers.open_containers[clicker:get_player_name()] = { pos = pos,
			sound = node_def.sound_close, swap = node.name }
end

function containers.protected.on_blast() end

function containers.protected.allow_metadata_inventory_move(pos, _, _, _ , _, 
	count, player)
	if not default.can_interact_with_node(player, pos) then
		return 0
	end
	return count
end

function containers.protected.allow_metadata_inventory_put(pos, _, _, stack, 
	player)
	if not default.can_interact_with_node(player, pos) then
		return 0
	end
	return stack:get_count()
end

function containers.protected.allow_metadata_inventory_take(pos, _, _, stack, 
	player)
	if not default.can_interact_with_node(player, pos) then
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

	minetest.show_formspec(player:get_player_name(), minetest.get_node(pos).name,
		containers.get_chest_formspec(pos))
end

function containers.protected.on_skeleton_key_use(pos, player, newsecret)
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")
	local pn = player:get_player_name()

	-- verify placer is owner of lockable chest
	-- TODO
	if owner ~= pn then
		minetest.record_protection_violation(pos, pn)
		minetest.chat_send_player(pn, S("You do not own this chest."))
		return nil
	end

	local secret = meta:get_string("key_lock_secret")
	if secret == "" then
		secret = newsecret
		meta:set_string("key_lock_secret", secret)
	end

	return secret, S("a locked chest"), owner
end

function containers.on_metadata_inventory_move(pos, _, _, _, _, _, player)
	minetest.log("action", player:get_player_name() ..
		" moves stuff in chest at " .. minetest.pos_to_string(pos))
end

function containers.on_metadata_inventory_put(pos, _, _, stack, player)
	minetest.log("action", player:get_player_name() ..
		" moves " .. stack:get_name() ..
		" to chest at " .. minetest.pos_to_string(pos))
end

function containers.on_metadata_inventory_take(pos, _, _, stack, player)
	minetest.log("action", player:get_player_name() ..
		" takes " .. stack:get_name() ..
		" from chest at " .. minetest.pos_to_string(pos))
end

local open = {}

function open.can_dig() return false end
function open.on_blast() end

local function register_container(name, def)
	local txt = name:gsub(":", "_")
	local callbacks_p = def.protected and containers.protected or 
		containers.unprotected

	local groups
	if def.groups then
		groups = table.copy(def.groups)
	else
		groups = {choppy = 2, oddly_breakable_by_hand = 2}
	end

	local diff = {}
	if def.sub == "_opened" then
		groups.not_in_creative_inventory = 1
		diff.drop = def.drop or name
		diff.can_dig = open.can_dig
		diff.on_blast = open.on_blast
		diff.mesh = def.mesh
		diff.drawtype = def.drawtype or "mesh"
		diff.visual = def.visual or "mesh"
		diff.selection_box = def.selection_box or {
			type = "fixed",
			fixed = { -1/2, -1/2, -1/2, 1/2, 3/16, 1/2 },
		}
		if def.tiles then
			diff.tiles = table.copy(def.tiles)
			diff.tiles[3] = diff.tiles[4] 
			diff.tiles[5] = diff.tiles[6]
			diff.tiles[6] = def.inside
		else
			diff.tiles = {txt .. "_top.png", txt .. "_top.png", txt .. "_side.png", 
				txt .. "_side.png", txt .. "_front.png", txt .. "_inside.png"
			}
		end
	else
		diff.drop = def.drop
		diff.can_dig = callbacks_p.can_dig
		diff.on_blast = callbacks_p.on_blast
		if def.tiles then
			diff.tiles = table.copy(def.tiles)
			diff.tiles[3] = diff.tiles[3] .. "^[transformFX"
		else
			diff.tiles = {txt .. "_top.png", txt .. "_top.png",
				txt .. "_side.png^[transformFX", txt .. "_side.png", txt .. "_side.png",
				txt .. "_front.png",
			}
		end
		diff.inventory_width = def.inventory_width or 8
		diff.inventory_height = def.inventory_height or 4
	end

	minetest.register_node(name .. def.sub, {
		description = def.description or txt,
		drawtype = diff.drawtype,
		visual = diff.visual,
		mesh = diff.mesh,
		tiles = diff.tiles,
		groups = groups,
		drop = diff.drop,
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = diff.selection_box,
		legacy_facedir_simple = true,
		is_ground_content = false,
		inventory_width = diff.inventory_width,
		inventory_height = diff.inventory_height,
		sounds = def.sounds or trees.node_sound_wood_defaults(),
		sound_open = def.sound_open or txt .. "_open",
		sound_close = def.sound_close or txt .. "_close",
		can_dig = def.can_dig or diff.can_dig,
		on_blast = def.on_blast or diff.on_blast,
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
			or callbacks_p.on_skeleton_key_use
	})
end

function containers.register_container(name, def)
	def.closed.sub = ""
	register_container(name, def.closed)

	if def.opened then
		def.opened.sub = "_opened"
		def.opened.tiles = def.opened.tiles or def.closed.tiles
		register_container(name, def.opened)
	end
end

