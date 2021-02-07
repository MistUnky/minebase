-- base_screwdrivers/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_screwdrivers")

-- Screwdriver
screwdrivers.register_screwdriver("base_screwdrivers:screwdriver", {
	description = S("Screwdriver") .. "\n" .. S("(left-click rotates face, right\z
		-click rotates axis)"),
	on_use = function(itemstack, user, pointed_thing)
		screwdrivers.handler(itemstack, user, pointed_thing, 
			screwdrivers.ROTATE_FACE, 200)
		return itemstack
	end,
	on_place = function(itemstack, user, pointed_thing)
		screwdrivers.handler(itemstack, user, pointed_thing, 
			screwdrivers.ROTATE_AXIS, 200)
		return itemstack
	end,
	recipe = {
		{"base_ores:steel_ingot"},
		{"group:stick"}
	}
})


--[[TODO
screwdrivers.register_screwdriver("base_screwdrivers:abc", {
	description = S("abc") .. "\n" .. S("(left-click , right\z
		-click )"),
	on_use = function(itemstack, user, pointed_thing)
		print("use")
		screwdrivers.abc(itemstack, user, pointed_thing, 1)
		return itemstack
	end,
	on_place = function(itemstack, user, pointed_thing)
		print("place")
		screwdrivers.abc(itemstack, user, pointed_thing, 2)
		return itemstack
	end,
})
--]]
