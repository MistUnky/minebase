-- borders_api/init.lua

borders = {}

function borders.register_layer(name, def)
	minetest.register_ore({
		ore_type = "stratum",
		ore = def.ore or name,
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

