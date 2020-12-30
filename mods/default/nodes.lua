-- mods/default/nodes.lua

-- support for Minebase translation.
local S = default.get_translator

--
-- Tools / "Advanced" crafting / Non-"natural"
--

minetest.register_node("default:meselamp", {
	description = S("Mese Lamp"),
	tiles = {"default_meselamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	--TODO: sounds = default.node_sound_glass_defaults(),
	light_source = default.LIGHT_MAX,
})

--
-- Misc
--

minetest.register_node("default:cloud", {
	description = S("Cloud"),
	tiles = {"default_cloud.png"},
	is_ground_content = false,
	sounds = base_sounds.node_sound_defaults(),
	groups = {not_in_creative_inventory = 1},
})

