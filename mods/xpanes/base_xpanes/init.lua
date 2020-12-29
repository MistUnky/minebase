-- base_xpanes/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_xpanes")

xpanes.register_pane("base_xpanes:glass", {
	description = S("Glass Pane"),
	textures = {"base_glass_common_glass.png", "", "base_xpanes_glass_edge.png"},
	inventory_image = "base_glass_common_glass.png",
	wield_image = "base_glass_common_glass.png",
	sounds = glass.node_sound_glass_defaults(),
	groups = {snappy=2, cracky=3, oddly_breakable_by_hand=3},
	recipe = {
		{"base_glass:common_glass", "base_glass:common_glass", "base_glass:common_glass"},
		{"base_glass:common_glass", "base_glass:common_glass", "base_glass:common_glass"}
	}
})

xpanes.register_pane("base_xpanes:obsidian", {
	description = S("Obsidian Glass Pane"),
	textures = {"base_glass_obsidian_glass.png", "", "base_xpanes_obsidian_edge.png"},
	inventory_image = "base_glass_obsidian_glass.png",
	wield_image = "base_glass_obsidian_glass.png",
	sounds = glass.node_sound_glass_defaults(),
	groups = {snappy=2, cracky=3},
	recipe = {
		{"base_glass:obsidian_glass", "base_glass:obsidian_glass", "base_glass:obsidian_glass"},
		{"base_glass:obsidian_glass", "base_glass:obsidian_glass", "base_glass:obsidian_glass"}
	}
})
