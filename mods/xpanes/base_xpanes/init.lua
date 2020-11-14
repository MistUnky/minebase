-- base_xpanes/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_xpanes")

xpanes.register_pane("base_xpanes:glass", {
	description = S("Glass Pane"),
	textures = {"default_glass.png", "", "base_xpanes_glass_edge.png"},
	inventory_image = "default_glass.png",
	wield_image = "default_glass.png",
	sounds = default.node_sound_glass_defaults(),
	groups = {snappy=2, cracky=3, oddly_breakable_by_hand=3},
	recipe = {
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

xpanes.register_pane("base_xpanes:obsidian", {
	description = S("Obsidian Glass Pane"),
	textures = {"default_obsidian_glass.png", "", "base_xpanes_obsidian_edge.png"},
	inventory_image = "default_obsidian_glass.png",
	wield_image = "default_obsidian_glass.png",
	sounds = default.node_sound_glass_defaults(),
	groups = {snappy=2, cracky=3},
	recipe = {
		{"default:obsidian_glass", "default:obsidian_glass", "default:obsidian_glass"},
		{"default:obsidian_glass", "default:obsidian_glass", "default:obsidian_glass"}
	}
})
