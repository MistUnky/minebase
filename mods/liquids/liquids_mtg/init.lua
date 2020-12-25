-- liquids_mtg/init.lua

-- Aliases to support loading worlds using nodes following the old naming convention
-- These can also be helpful when using chat commands, for example /giveme
minetest.register_alias("water_flowing", "base_liquids:water_flowing")
minetest.register_alias("water_source", "base_liquids:water_source")
minetest.register_alias("lava_flowing", "base_liquids:lava_flowing")
minetest.register_alias("lava_source", "base_liquids:lava_source")
minetest.register_alias("snow", "base_liquids:snow")

minetest.register_alias("default:ice", "base_liquids:ice")
minetest.register_alias("default:lava_flowing", "base_liquids:lava_flowing")
minetest.register_alias("default:lava", "base_liquids:lava")
minetest.register_alias("default:lava_source", "base_liquids:lava_source")
minetest.register_alias("default:river_water_flowing", 
	"base_liquids:river_water_flowing")
minetest.register_alias("default:river_water_source", 
	"base_liquids:river_water_source")
minetest.register_alias("default:snowball", "base_liquids:snowball")
minetest.register_alias("default:snowblock", "base_liquids:snow_block")
minetest.register_alias("default:snow", "base_liquids:snow")
minetest.register_alias("default:water_flowing", "base_liquids:water_flowing")
minetest.register_alias("default:water_source", "base_liquids:water_source")
