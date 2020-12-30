-- containers/init.lua

-- Aliases to support loading worlds using nodes following the old naming convention
-- These can also be helpful when using chat commands, for example /giveme
minetest.register_alias("chest", "default:chest")
minetest.register_alias("locked_chest", "default:chest_locked")
minetest.register_alias("bookshelf", "default:bookshelf")

--[[
	-- convert old chests to this new variant
	if name == "chests:common" or name == "chests:common_locked" then
		minetest.register_lbm({
			label = "update chests to opening chests",
			name = "chests:upgrade_" .. name:sub(9,-1) .. "_v2",
			nodenames = {name},
			action = function(pos, node)
				local meta = minetest.get_meta(pos)
				meta:set_string("formspec", nil)
				local inv = meta:get_inventory()
				local list = inv:get_list("chests:common")
				if list then
					inv:set_size("main", 8*4)
					inv:set_list("main", list)
					inv:set_list("chests:common", nil)
				end
			end
		})
	end
]]
