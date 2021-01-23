-- farming_loot/init.lua

local loot = {}

if minetest.global_exists("wheat") then
	table.insert({name = "wheat:wheat", chance = 0.5, count = {2, 5}})
end

if minetest.global_exists("dungeon_loot") then
	table.insert(loot, {name = "cotton:string", chance = 0.5, count = {1, 8}})
	table.insert(loot, {name = "cotton:seed_cotton", chance = 0.4, count = {1, 4},
			types = {"normal"}})
end

dungeon_loot.register(loot)
