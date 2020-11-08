-- base_doors/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_doors")

doors.register("base_doors:wood", {
		tiles = {{ name = "base_doors_wood.png", backface_culling = true }},
		description = S("Wooden Door"),
		inventory_image = "base_doors_item_wood.png",
		groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"group:wood", "group:wood"},
			{"group:wood", "group:wood"},
			{"group:wood", "group:wood"},
		}
})

doors.register("base_doors:steel", {
		tiles = {{name = "base_doors_steel.png", backface_culling = true}},
		description = S("Steel Door"),
		inventory_image = "base_doors_item_steel.png",
		protected = true,
		groups = {node = 1, cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_api_steel_open",
		sound_close = "doors_api_steel_close",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot"},
		}
})

doors.register("base_doors:glass", {
		tiles = {"base_doors_glass.png"},
		description = S("Glass Door"),
		inventory_image = "base_doors_item_glass.png",
		groups = {node = 1, cracky=3, oddly_breakable_by_hand=3},
		sounds = default.node_sound_glass_defaults(),
		sound_open = "doors_api_glass_open",
		sound_close = "doors_api_glass_close",
		recipe = {
			{"default:glass", "default:glass"},
			{"default:glass", "default:glass"},
			{"default:glass", "default:glass"},
		}
})

doors.register("base_doors:obsidian_glass", {
		tiles = {"base_doors_obsidian_glass.png"},
		description = S("Obsidian Glass Door"),
		inventory_image = "base_doors_item_obsidian_glass.png",
		groups = {node = 1, cracky=3},
		sounds = default.node_sound_glass_defaults(),
		sound_open = "doors_api_glass_open",
		sound_close = "doors_api_glass_close",
		recipe = {
			{"default:obsidian_glass", "default:obsidian_glass"},
			{"default:obsidian_glass", "default:obsidian_glass"},
			{"default:obsidian_glass", "default:obsidian_glass"},
		},
})

----fuels----

minetest.register_craft({
	type = "fuel",
	recipe = "base_doors:wood",
	burntime = 14,
})

