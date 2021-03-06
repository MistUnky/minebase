-- trash/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("trash")

trash = {}

function trash.on_rightclick(_, _, clicker, itemstack)
	local keys = clicker:get_player_control()
	if keys and keys.aux1 then
		return ItemStack("")
	else
		itemstack:take_item()
		return itemstack
	end
end

minetest.register_node("trash:trash", {
	description = S("Trash") .. "\n" .. S("(right-click dumps one item, aux + \z
		right-click dumps an itemstack)"),
	groups = {dig_immediate = 2},
	is_ground_content = false,
	sounds = sounds.get_defaults("ore_sounds:metal"),
	tiles = {"trash_trash_top.png", "trash_trash_bottom.png", 
		"trash_trash_side.png", "trash_trash_side.png", "trash_trash_side.png",
		"trash_trash_side.png"},
	on_rightclick = trash.on_rightclick
})

minetest.register_craft({
	output = "trash:trash",
	recipe = {
		{"base_ores:steel_ingot", "base_ores:steel_ingot", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "base_earth:dirt", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "base_ores:steel_ingot", "base_ores:steel_ingot"}
	}
})
