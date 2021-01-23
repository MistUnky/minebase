-- earth_dungeon_loot/init.lua

dungeon_loot.register({
	{name = "base_earth:flint", chance = 0.4, count = {1, 3}},
	{name = "base_earth:sand", chance = 0.8, count = {4, 32}, y = {-64, 32768}, 
		types = {"normal"}},
	{name = "base_earth:desert_sand", chance = 0.8, count = {4, 32}, 
		y = {-64, 32768}, types = {"sandstone"}},
	{name = "base_earth:desert_cobble", chance = 0.8, count = {4, 32}, 
		types = {"desert"}},
	{name = "base_earth:dirt", chance = 0.6, count = {2, 16}, y = {-64, 32768}, 
		types = {"normal", "sandstone", "desert"}}
})

