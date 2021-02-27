dungeon_loot = {}

dungeon_loot.CHESTS_MIN = 0 -- not necessarily in a single dungeon
dungeon_loot.CHESTS_MAX = 2
dungeon_loot.STACKS_PER_CHEST_MAX = 8
dungeon_loot.registered_loot = {}

function dungeon_loot.register(loot)
	if loot.name then
		table.insert(dungeon_loot.registered_loot, loot)
	else
		for _, item in ipairs(loot) do
			table.insert(dungeon_loot.registered_loot, item)
		end
	end
end

function dungeon_loot.get_loot(pos_y, dungeontype)
	-- filter by y pos and type
	local ret, parts = {}, {}
	for _, loot in ipairs(dungeon_loot.registered_loot) do
		if loot.y == nil or (pos_y >= loot.y[1] and pos_y <= loot.y[2]) then
			if loot.types == nil or table.indexof(loot.types, dungeontype) ~= -1 then
				table.insert(ret, loot)
				table.insert(parts, loot.part)
			end
		end
	end
	return ret, parts
end

dofile(minetest.get_modpath("dungeon_loot_api") .. "/mapgen.lua")


