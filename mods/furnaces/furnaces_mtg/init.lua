-- furnace_mtg/init.lua

-- Aliases to support loading worlds using nodes following the old naming convention
-- These can also be helpful when using chat commands, for example /giveme
minetest.register_alias("furnace", "base_furnaces:furnace")

minetest.register_alias("default:furnace", "base_furnaces:furnace")
minetest.register_alias("default:furnace_active", 
	"base_furnaces:furnace_active")
