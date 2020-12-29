-- glass/init.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("glass")

glass.register_glass("base_glass:common", {
	description = S("Glass"),
	input = "group:sand"
})

glass.register_glass("base_glass:obsidian", {
	description = S("Obsidian Glass"),
	groups = {cracky = 3},
	input = "base_liquids:obsidian_shard"
})

