-- torch/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("torch")

lights.register_torch("torch:common", {
	floor = {
		description = S("Torch"),
		burntime = 4,
		on_place = function(itemstack, placer, pointed_thing)
			local under = pointed_thing.under
			local node = minetest.get_node(under)
			local def = minetest.registered_nodes[node.name]
			if def and def.on_rightclick and
				not (placer and placer:is_player() and
				placer:get_player_control().sneak) then
				return def.on_rightclick(under, node, placer, itemstack,
					pointed_thing) or itemstack
			end

			local above = pointed_thing.above
			local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
			local fakestack = itemstack
			if wdir == 0 then
				fakestack:set_name("torch:common_ceiling")
			elseif wdir == 1 then
				fakestack:set_name("torch:common")
			else
				fakestack:set_name("torch:common_wall")
			end

			itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
			itemstack:set_name("torch:common")

			return itemstack
		end,
	},
	wall = {description = S("Torch")},
	ceiling = {description = S("Torch")}
})

minetest.register_craft({
	output = "torch:common_floor 4",
	recipe = {
		{"base_ores:coal_lump"},
		{"group:stick"},
	}
})

