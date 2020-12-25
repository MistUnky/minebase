-- grasses_api/init.lua



grasses = {}

function grasses.register_grass(name, def)
	local txt = name:gsub(":", "_")
	local groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1}
	for fi = 1, def.max do
		if fi ~= 1 then
			groups.not_in_creative_inventory = 1
		else
			groups.not_in_creative_inventory = nil
		end
		minetest.register_node(name .. "_grass_" .. fi, {
			description = def.description or txt,
			drawtype = "plantlike",
			waving = def.waving or 1,
			visual_scale = def.visual_scale,
			tiles = def.tiles or {txt .. "_grass_".. fi .. ".png"},
			inventory_image = def.inventory_image or txt .. "_grass_".. fi .. ".png",
			wield_image = def.wield_image or txt .. "_grass_".. fi .. ".png",
			paramtype = "light",
			sunlight_propagates = true,
			walkable = false,
			buildable_to = true,
			drop = def.drop or name .. "_grass_1",
			groups = def.groups or groups,
			sounds = trees.node_sound_leaves_defaults(),
			selection_box = def.selection_box or {
				type = "fixed",
				fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, def.height or 5, 6 / 16},
			},
		})
	end
end
