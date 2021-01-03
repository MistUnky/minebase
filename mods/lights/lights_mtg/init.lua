-- lights_mtg/init.lua

-- Aliases to support loading worlds using nodes following the old naming convention
-- These can also be helpful when using chat commands, for example /giveme
minetest.register_alias("torch", "torch:common")

minetest.register_lbm({
	name = "lights_mtg:3dtorch",
	nodenames = {"torch:common_floor", "torches:floor", "torches:wall"},
	action = function(pos, node)
		if node.param2 == 0 then
			minetest.set_node(pos, {name = "torch:common_ceiling",
				param2 = node.param2})
		elseif node.param2 == 1 then
			minetest.set_node(pos, {name = "torch:common",
				param2 = node.param2})
		else
			minetest.set_node(pos, {name = "torch:common_wall",
				param2 = node.param2})
		end
	end
})

minetest.register_alias("default:torch_ceiling", "torch:common_ceiling")
minetest.register_alias("default:torch", "torch:common")
minetest.register_alias("default:torch_wall", "torch:common_wall")

minetest.register_alias("default:meselamp", "meselamp:lamp")
