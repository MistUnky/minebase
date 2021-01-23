-- ore_dungeon_loot/init.lua

dungeon_loot.register({
	{name = "base_ores:coal_lump", chance = 0.9, count = {1, 12}},
	{name = "base_ores:gold_ingot", chance = 0.5},
	{name = "base_ores:steel_ingot", chance = 0.4, count = {1, 6}},
	{name = "base_ores:mese_crystal", chance = 0.1, count = {2, 3}},
	{name = "base_ores:mese_block", chance = 0.15, y = {-32768, -512}}
})
