-- torch/init.lua
-- support for Minebase translation.
local S = default.get_translator

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

minetest.register_lbm({
	name = "torch:3dtorch",
	nodenames = {"torch:common_floor", "torches:floor", "torches:wall"},
	action = function(pos, node)
		if node.param2 == 0 then
			minetest.set_node(pos, {name = "torch:common_ceiling",
				param2 = node.param2})
		elseif node.param2 == 1 then
			minetest.set_node(pos, {name = "torch:common_floor",
				param2 = node.param2})
		else
			minetest.set_node(pos, {name = "torch:common_wall",
				param2 = node.param2})
		end
	end
})

