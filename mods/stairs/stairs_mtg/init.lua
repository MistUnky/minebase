-- stairs_mtg/init.lua 

-- Register aliases for new pine node names
minetest.register_alias("stairs:stair_pinewood", "stairs:stair_pine_wood")
minetest.register_alias("stairs:slab_pinewood", "stairs:slab_pine_wood")

--[[
-- Get setting for replace ABM

local replace = minetest.settings:get_bool("enable_stairs_replace_abm")

	-- for replace ABM
	if replace then
		minetest.register_node(name .. "_upside_down", {
			replace_name = name,
			groups = {slabs_replace = 1},
		})
	end

	-- for replace ABM
	if replace then
		minetest.register_node(name .. "_upside_down", {
			replace_name = name,
			groups = {slabs_replace = 1},
		})
	end

-- Optionally replace old "upside_down" nodes with new param2 versions.
-- Disabled by default.

if replace then
	minetest.register_abm({
		label = "Slab replace",
		nodenames = {"group:slabs_replace"},
		interval = 16,
		chance = 1,
		action = function(pos, node)
			node.name = minetest.registered_nodes[node.name].replace_name
			node.param2 = node.param2 + 20
			if node.param2 == 21 then
				node.param2 = 23
			elseif node.param2 == 23 then
				node.param2 = 21
			end
			minetest.set_node(pos, node)
		end,
	})
end

--]]
