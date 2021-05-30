-- borders_api/init.lua

borders = {x = {}, z = {}}

function borders.register_layer(def)
	minetest.register_ore({
		ore_type = "stratum",
		ore = def.ore,
		ore_param2 = def.ore_param2,
		wherein = def.wherein,
		clust_scarcity = 1,
		clust_num_ores = 1,
		clust_size = 1,
		y_max = def.y + 2,
		y_min = def.y,
		stratum_thickness = 3
	})
end

function borders.register_wall(def)
	if not borders[def.axis][def.value]	then
		borders[def.axis][def.value] = def.node
	end
end

minetest.register_on_generated(function(min, max, blockseed)
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local data = vm:get_data()
	local va = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
	local pmin = vector.new(emin)
	local pmax = vector.new(emax)
	local cId 
	for x, name in pairs(borders.x) do
		cId = minetest.get_content_id(name)
		if x >= emin.x and x <= emax.x then
			if vm:get_node_at({x = x, y = emin.y + 40, z = emin.z + 40}).name ~= name 
				then
				pmin.x = x
				pmax.x = x
				for index in va:iterp(pmin, pmax) do
					data[index] = cId
				end
			end
		end
	end
	pmin = vector.new(emin)
	pmax = vector.new(emax)
	for z, name in pairs(borders.z) do
		cId = minetest.get_content_id(name)
		if z >= emin.z and z <= emax.z then
			if vm:get_node_at({x = emin.x + 40, y = emin.y + 40, z = z}).name ~= name 
				then
				pmin.z = z
				pmax.z = z
				for index in va:iterp(pmin, pmax) do
					data[index] = cId
				end
			end
		end
	end
	vm:set_data(data)
	vm:calc_lighting()
	vm:write_to_map(true)
end)
