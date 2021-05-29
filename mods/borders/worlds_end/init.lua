-- worlds_end/init.lua

minetest.register_node("worlds_end:air", {
	description = "Air",
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
