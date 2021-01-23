-- buckets_dungeon_loot/init.lua

local loot = {{name = "buckets_api:bucket_empty", chance = 0.55}}

if minetest.get_modpath("buckets_lava") then
	table.insert(loot, {name = "buckets_lava:bucket", chance = 0.45, 
		y = {-32768, -1}, types = {"normal"}})
end

if minetest.get_modpath("buckets_water") then
	table.insert(loot, {name = "buckets_water:bucket", chance = 0.45,
		types = {"sandstone", "desert", "ice"}})
	table.insert(loot, {name = "buckets_water:bucket", chance = 0.45, 
		y = {0, 32768}, types = {"normal"}})
end

dungeon_loot.register(loot)

