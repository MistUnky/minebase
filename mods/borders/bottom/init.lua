-- bottom/init.lua

local S = minetest.get_translator("bottom")

earth.register_stone("bottom:bedrock", {
	description = S("Bedrock"),
	groups = {not_in_creative_inventory = 1},
	node_dig_prediction = "bottom:bedrock",
	tiles = {"base_earth_stone.png^[colorize:#00000099"},
	is_ground_content = false,
	pointable = false,
	diggable = false,
	damage_per_second = 1,
	on_blast = function() end
})

borders.register_layer({
	ore = "bottom:bedrock",
	wherein = {"group:stone", "air", "group:sand", "base_earth:dirt", 
		"base_earth:gravel"},
	y = -30912
})

