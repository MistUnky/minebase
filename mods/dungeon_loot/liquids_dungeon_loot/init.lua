-- liquids_dungeon_loot/init.lua 

dungeon_loot.register({
	{name = "base_liquids:snow", chance = 0.8, count = {8, 64}, y = {-64, 32768}, 
		types = {"ice"}},
	{name = "base_liquids:obsidian", chance = 0.25, count = {1, 3}, 
		y = {-32768, -512}}
})

