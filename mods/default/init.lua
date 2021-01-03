-- default/init.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("default")

-- Definitions made by this mod that other mods can use too
default = {}

default.LIGHT_MAX = 14

-- Load files
local default_path = minetest.get_modpath("default")

dofile(default_path.."/item_entity.lua")
--dofile(default_path.."/legacy.lua")


