-- base_dungeon_loot/init.lua 

local loot = {
	-- various items
	{name = "default:stick", chance = 0.6, count = {3, 6}},
	{name = "base_earth:flint", chance = 0.4, count = {1, 3}},

	-- natural materials
	{name = "base_earth:sand", chance = 0.8, count = {4, 32}, y = {-64, 32768},
		types = {"normal"}},
	{name = "base_earth:desert_sand", chance = 0.8, count = {4, 32}, y = {-64, 32768},
		types = {"sandstone"}},
	{name = "base_earth:desert_cobble", chance = 0.8, count = {4, 32},
		types = {"desert"}},
	{name = "base_liquids:snow", chance = 0.8, count = {8, 64}, y = {-64, 32768},
		types = {"ice"}},
	{name = "base_earth:dirt", chance = 0.6, count = {2, 16}, y = {-64, 32768},
		types = {"normal", "sandstone", "desert"}},
	{name = "base_liquids:obsidian", chance = 0.25, count = {1, 3}, y = {-32768, -512}},
}

-- minerals
if minetest.get_modpath("base_ores") ~= nil then
	table.insert(loot, {name = "base_ores:coal_lump", chance = 0.9, 
		count = {1, 12}})
	table.insert(loot, {name = "base_ores:gold_ingot", chance = 0.5})
	table.insert(loot, {name = "base_ores:steel_ingot", chance = 0.4, 
		count = {1, 6}})
	table.insert(loot, {name = "base_ores:mese_crystal", chance = 0.1, 
		count = {2, 3}})
	table.insert(loot, {name = "base_ores:mese_block", chance = 0.15, 
		y = {-32768, -512}})
end

-- tools
if minetest.get_modpath("base_tools") ~= nil then
	table.insert(loot, {name = "base_tools:wood_sword", chance = 0.6})
	table.insert(loot, {name = "base_tools:stone_pick", chance = 0.3})
	table.insert(loot, {name = "base_tools:diamond_axe", chance = 0.05})
end

-- consumable
if minetest.get_modpath("base_trees") ~= nil then
	table.insert(loot, {name = "default:apple", chance = 0.4, count = {1, 4}})
end

if minetest.get_modpath("cactus") ~= nil then
	table.insert(loot, {name = "default:cactus", chance = 0.4, count = {1, 4},
		types = {"sandstone", "desert"}})
end

dungeon_loot.register(loot)
