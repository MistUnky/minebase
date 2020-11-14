dungeon_loot = {}

dungeon_loot.CHESTS_MIN = 0 -- not necessarily in a single dungeon
dungeon_loot.CHESTS_MAX = 2
dungeon_loot.STACKS_PER_CHEST_MAX = 8
dungeon_loot.registered_loot = {}

function dungeon_loot.register(t)
	if t.name ~= nil then
		t = {t} -- single entry
	end
	for _, loot in ipairs(t) do
		table.insert(dungeon_loot.registered_loot, loot)
	end
end

function dungeon_loot._internal_get_loot(pos_y, dungeontype)
	-- filter by y pos and type
	local ret = {}
	for _, l in ipairs(dungeon_loot.registered_loot) do
		if l.y == nil or (pos_y >= l.y[1] and pos_y <= l.y[2]) then
			if l.types == nil or table.indexof(l.types, dungeontype) ~= -1 then
				table.insert(ret, l)
			end
		end
	end
	return ret
end

dofile(minetest.get_modpath("dungeon_loot_api") .. "/mapgen.lua")
