-- base_carts/init.lua

-- support for Minebase translation.
local S = minetest.get_translator("base_carts")

carts.register_cart("base_carts:cart", {
	craftitem = {
		description = S("Cart") .. "\n" .. S("aux + left-click to pick up"),
		recipe = {
			{"base_ores:steel_ingot", "", "base_ores:steel_ingot"},
			{"base_ores:steel_ingot", "base_ores:steel_ingot", 
				"base_ores:steel_ingot"},
		}
	}
})

