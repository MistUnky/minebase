-- base_dungeon_loot/init.lua 

local loot = {}

if minetest.get_modpath("base_earth") then
	-- various items
	table.insert(loot, {name = "base_earth:flint", chance = 0.4, count = {1, 3}})
	-- natural materials
	table.insert(loot, {name = "base_earth:sand", chance = 0.8, count = {4, 32}, 
		y = {-64, 32768}, types = {"normal"}})
	table.insert(loot, {name = "base_earth:desert_sand", chance = 0.8, 
		count = {4, 32}, y = {-64, 32768}, types = {"sandstone"}})
	table.insert(loot, {name = "base_earth:desert_cobble", chance = 0.8, 
		count = {4, 32}, types = {"desert"}})
	table.insert(loot, {name = "base_earth:dirt", chance = 0.6, count = {2, 16}, 
		y = {-64, 32768}, types = {"normal", "sandstone", "desert"}})
end

-- minerals
if minetest.get_modpath("base_ores") then
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
if minetest.get_modpath("base_tools") then
	table.insert(loot, {name = "base_tools:wood_sword", chance = 0.6})
	table.insert(loot, {name = "base_tools:stone_pick", chance = 0.3})
	table.insert(loot, {name = "base_tools:diamond_axe", chance = 0.05})
end

-- consumable
if minetest.get_modpath("base_trees") then
	table.insert(loot, {name = "base_trees:apple", chance = 0.4, count = {1, 4}})
	table.insert(loot, {name = "base_trees:stick", chance = 0.6, count = {3, 6}})
end

if minetest.get_modpath("cactus") then
	table.insert(loot, {name = "cactus:cactus", chance = 0.4, count = {1, 4},
		types = {"sandstone", "desert"}})
end

if minetest.get_modpath("base_liquids") then
	table.insert(loot, {name = "base_liquids:snow", chance = 0.8, count = {8, 64}, 
		y = {-64, 32768}, types = {"ice"}})
	table.insert(loot, {name = "base_liquids:obsidian", chance = 0.25, 
		count = {1, 3}, y = {-32768, -512}})
end

dungeon_loot.register(loot)
