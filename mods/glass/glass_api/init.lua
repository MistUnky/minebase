-- glass_api/init.lua 

glass = {}

function glass.node_sound_glass_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "glass_api_footstep", gain = 0.3}
	table.dig = table.dig or
			{name = "glass_api_footstep", gain = 0.5}
	table.dug = table.dug or
			{name = "glass_api_break", gain = 1.0}
	base_sounds.node_sound_defaults(table)
	return table
end

function glass.register_glass(name, def)
	local txt = name:gsub(":", "_")
	name = name .. "_glass"
	minetest.register_node(name, {
		description = def.description or txt,
		drawtype = def.drawtype or "glasslike_framed_optional",
		tiles = def.tiles or {txt .. "_glass.png", txt .. "_glass_detail.png"},
		paramtype = "light",
		paramtype2 = def.paramtype2 or "glasslikeliquidlevel",
		sunlight_propagates = true,
		is_ground_content = false,
		groups = def.groups or {cracky = 3, oddly_breakable_by_hand = 3},
		sounds = def.sounds or glass.node_sound_glass_defaults(),
	})

	if def.input then
		minetest.register_craft({
			type = "cooking",
			output = name,
			recipe = def.input
		})
	end
end
