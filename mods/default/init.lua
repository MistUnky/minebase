-- default/init.lua 

-- The API documentation in here was moved into game_api.txt

-- Load support for Minebase translation.
local S = minetest.get_translator("default")

-- Definitions made by this mod that other mods can use too
default = {}

default.LIGHT_MAX = 14
default.get_translator = S


-- Load files
local default_path = minetest.get_modpath("default")


--dofile(default_path.."/furnace.lua")
dofile(default_path.."/item_entity.lua")
dofile(default_path.."/craftitems.lua")
dofile(default_path.."/aliases.lua")
--dofile(default_path.."/legacy.lua")


minetest.register_node("default:meselamp", {
	description = S("Mese Lamp"),
	tiles = {"default_meselamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	--TODO: sounds = default.node_sound_glass_defaults(),
	light_source = default.LIGHT_MAX,
})

minetest.register_craft({
	output = "default:meselamp",
	recipe = {
		{"default:glass"},
		{"default:mese_crystal"},
	}
})

