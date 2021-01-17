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
	stairs.register_glass_all("steel_bars:block", {
		material = "steel_bars:bar",
		groups = {cracky = 1, oddly_breakable_by_hand = 3},
		sounds = ores.node_sound_metal_defaults(),
		worldaligntex = false,
		stair_description = S("Steel Bar Stair"),
		slab_description = S("Steel Bar Slab"),
		inner_stair_description = S("Inner Steel Bar Stair"),
		outer_stair_description = S("Outer Steel Bar Stair"),
		step_description = S("Steel Bar Step"),
		inner_step_description = S("Inner Steel Bar Step"),
		outer_step_description = S("Outer Steel Bar Step"),
		steps_description = S("Steel Bar Steps"),
		steps_half_description = S("Steel Bar Steps Half"),
		steps_slab_description = S("Steel Bar Steps Slab"),
		full = "steel_bars_bars.png",
		split = "steel_bars_stair_split.png",
		stairside = "steel_bars_stairside.png",
		outer_stairside = "steel_bars_stair_outer_side.png",
		quartered = "steel_bars_stair_outer_side.png",
	})
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

