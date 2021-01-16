-- steel_bars/init.lua

dofile(minetest.get_modpath("steel_bars") .. "/mtg.lua")

-- Load support for Minebase translation.
local S = minetest.get_translator("steel_bars")


minetest.register_craftitem("steel_bars:bar", {
	description = S("Steel Bar"),
	inventory_image = "steel_bars_bar.png",
})

minetest.register_craft({
	output = "steel_bars:bar",
	type = "shaped",
	recipe = {
		{"base_ores:steel_ingot","",""},
		{"base_ores:steel_ingot","",""},
		{"base_ores:steel_ingot","",""}
	}
})

minetest.register_craft({
	output = "base_ores:steel_ingot 3",
	type = "cooking",
	recipe = "steel_bars:bar",
	cooktime = 4
})


minetest.register_node("steel_bars:block", {
	description = S("Steel Bar Block"),
	drawtype = "glasslike_framed_optional",
	tiles = {"steel_bars_bars.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = ores.node_sound_metal_defaults(),
})

minetest.register_craft({
	output = "steel_bars:block",
	type = "shaped",
	recipe = {
		{"steel_bars:bar", "steel_bars:bar", "steel_bars:bar"},
		{"steel_bars:bar", "steel_bars:bar", "steel_bars:bar"},
		{"steel_bars:bar", "steel_bars:bar", "steel_bars:bar"}
	}
})


if minetest.get_modpath("base_tools") then
	minetest.register_craft({
		output = "base_tools:steel_pick",
		recipe = {
			{"", "steel_bars:bar", ""},
			{"", "group:stick", ""},
			{"", "group:stick", ""}
		}
	})
end

if minetest.get_modpath("base_ladders") then
	minetest.register_craft({
		output = "base_ladders:steel_ladder 15",
		type = "shaped",
		recipe = {
			{"","",""},
			{"steel_bars:bar","base_ores:steel_ingot","steel_bars:bar"},
			{"","",""}
		}
	})
end

if minetest.get_modpath("xpanes_api") then
	xpanes.register_pane("steel_bars:bars", {
		description = S("Steel Bars"),
		textures = {"steel_bars_bars.png", "", "steel_bars_bars_top.png"},
		inventory_image = "steel_bars_bars.png",
		wield_image = "steel_bars_bars.png",
		groups = {cracky=2},
		sounds = ores.node_sound_metal_defaults(),
		recipe = {
			{"steel_bars:bar", "steel_bars:bar", "steel_bars:bar"},
			{"steel_bars:bar", "steel_bars:bar", "steel_bars:bar"}
		}
	})
end

-- Register steel bar doors and trapdoors

if minetest.get_modpath("doors_api") then
	doors.register("steel_bars:door", {
		tiles = {{name = "steel_bars_door.png", backface_culling = true}},
		description = S("Steel Bar Door"),
		inventory_image = "steel_bars_door_item.png",
		protected = true,
		groups = {node = 1, cracky = 1, level = 2},
		sounds = ores.node_sound_metal_defaults(),
		sound_open = "steel_bars_door_open",
		sound_close = "steel_bars_door_close",
		recipe = {
			{"steel_bars:bar", "steel_bars:bar"},
			{"steel_bars:bar", "steel_bars:bar"},
			{"steel_bars:bar", "steel_bars:bar"},
		},
	})

	doors.register_trapdoor("steel_bars:trapdoor", {
		description = S("Steel Bar Trapdoor"),
		inventory_image = "steel_bars_trapdoor.png",
		wield_image = "steel_bars_trapdoor.png",
		tile_front = "steel_bars_trapdoor.png",
		tile_side = "steel_bars_trapdoor_side.png",
		protected = true,
		groups = {node = 1, cracky = 1, level = 2, door = 1},
		sounds = ores.node_sound_metal_defaults(),
		sound_open = "steel_bars_door_open",
		sound_close = "steel_bars_door_close",
	})

	minetest.register_craft({
		output = "steel_bars:trapdoor",
		recipe = {
			{"steel_bars:bar", "steel_bars:bar"},
			{"steel_bars:bar", "steel_bars:bar"},
		}
	})
end

if minetest.get_modpath("stairs_api") then
	stairs.register_stair(
		"bars",
		"steel_bars:bar",
		{cracky = 1, oddly_breakable_by_hand = 3},
		{"steel_bars_stairs_split.png", "steel_bars_bars.png",
			"steel_bars_stairs_side.png^[transformFX", "steel_bars_stairs_side.png",
			"steel_bars_bars.png", "steel_bars_stairs_split.png"},
		S("Steel Bar Stair"),
		ores.node_sound_metal_defaults(),
		false
	)

	stairs.register_slab(
		"bars",
		"steel_bars:bar",
		{cracky = 1, oddly_breakable_by_hand = 3},
		{"steel_bars_bars.png", "steel_bars_bars.png", "steel_bars_stairs_split.png"},
		S("Steel Bar Slab"),
		ores.node_sound_metal_defaults(),
		false
	)

	stairs.register_stair_inner(
		"bars",
		"steel_bars:bar",
		{cracky = 1, oddly_breakable_by_hand = 3},
		{"steel_bars_stairs_side.png^[transformR270", "steel_bars_bars.png",
			"steel_bars_stairs_side.png^[transformFX", "steel_bars_bars.png",
			"steel_bars_bars.png", "steel_bars_stairs_side.png"},
		"",
		glass.node_sound_glass_defaults(),
		false,
		S("Inner Steel Bar Stair")
	)

	stairs.register_stair_outer(
		"bars",
		"steel_bars:bar",
		{cracky = 1, oddly_breakable_by_hand = 3},
		{"steel_bars_stairs_side.png^[transformR90", "steel_bars_bars.png",
		"steel_bars_stairs_outer_side.png", "steel_bars_stairs_side.png",
		"steel_bars_stairs_side.png^[transformR90","steel_bars_stairs_outer_side.png"},
		"",
		ores.node_sound_metal_defaults(),
		false,
		S("Outer Steel Bar Stair")
	)
end

if minetest.get_modpath("base_rails") then
	minetest.register_craft({
		output = "base_rails:rail 18",
		type = "shaped",
		recipe = {
			{"","group:wood",""},
			{"steel_bars:bar","","steel_bars:bar"},
			{"","group:wood",""}
		}
	})

	minetest.register_craft({
		output = "base_rails:powerrail 18",
		type = "shaped",
		recipe = {
			{"","group:wood",""},
			{"steel_bars:bar","base_ores:mese_crystal","steel_bars:bar"},
			{"","group:wood",""}
		}
	})

	minetest.register_craft({
		output = "base_rails:brakerail 18",
		type = "shaped",
		recipe = {
			{"","group:wood",""},
			{"steel_bars:bar","base_ores:coal_lump","steel_bars:bar"},
			{"","group:wood",""}
		}
	})
end

