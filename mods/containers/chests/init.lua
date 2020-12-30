-- chests/init.lua

chest = {}

-- support for Minebase translation.
local S = minetest.get_translator("chests")

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "chests:common" then
		return
	end
	if not player or not fields.quit then
		return
	end
	local pn = player:get_player_name()

	if not containers.open_containers[pn] then
		return
	end

	containers.close(pn)
	return true
end)

minetest.register_on_leaveplayer(function(player)
	local pn = player:get_player_name()
	if containers.open_containers[pn] then
		containers.close(pn)
	end
end)

containers.register_container("chests:common", {
	closed = {description = S("Chest")},
	opened = {
		mesh = "chests_open.obj",
	}
})

containers.register_container("chests:common_locked", {
	closed = {
		description = S("Locked Chest"),
		tiles = {
			"chests_common_top.png",
			"chests_common_top.png",
			"chests_common_side.png",
			"chests_common_side.png",
			"chests_common_side.png",
			"chests_common_lock.png"
		},
		protected = true
	},
	opened = {
		mesh = "chests_open.obj",
		inside = "chests_common_inside.png"
	}
})

minetest.register_craft({
	output = "chests:common",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})

minetest.register_craft({
	output = "chests:common_locked",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "base_ores:steel_ingot", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "chests:common_locked",
	recipe = {"chests:common", "base_ores:steel_ingot"},
})

minetest.register_craft({
	type = "fuel",
	recipe = "chests:common",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "chests:common_locked",
	burntime = 30,
})
