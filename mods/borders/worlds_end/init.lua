-- worlds_end/init.lua

local S = minetest.get_translator("worlds_end")

minetest.register_node("worlds_end:air", {
	description = S("Dense Air"),
	groups = {not_in_creative_inventory = 1},
	node_dig_prediction = "worlds_end:air",
	drawtype = "airlike",
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	climbable = false,
	buildable_to = false,
	floodable = false,
	drop = ""
})

borders.register_wall({
	axis = "x",
	value = 30927,
	node = "worlds_end:air"
})

borders.register_wall({
	axis = "x",
	value = -30912,
	node = "worlds_end:air"
})

borders.register_wall({
	axis = "z",
	value = 30927,
	node = "worlds_end:air"
})

borders.register_wall({
	axis = "z",
	value = -30912,
	node = "worlds_end:air"
})
