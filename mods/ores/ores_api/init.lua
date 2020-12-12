-- ores_api/init.lua

-- Create a setting that sets the scarcity of ores to a percentage of the hard 
-- coded scarcity.

ores = {}

function ores.register_lump(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_craftitem(name .. "_lump", {
		description = def.description or txt .. "_lump",
		inventory_image = txt .. "_lump.png",
		groups = def.groups
	})
end

function ores.register_ingot(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_craftitem(name .. "_ingot", {
		description = def.description or txt .. "_ingot",
		inventory_image = txt .. "_ingot.png"
	})
end

function ores.register_mineral(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "_mineral", {
		description = def.description or txt .. "_mineral",
		tiles = def.tiles or {"default_stone.png^" .. txt .. "_mineral.png"},
		groups = def.groups or {cracky = 2},
		drop = def.drop or name .. "_lump",
		sounds = default.node_sound_stone_defaults(),
	})
end

function ores.register_block(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "_block", {
		description = def.description or txt .. "_block",
		tiles = def.tiles or {txt .. "_block.png"},
		is_ground_content = false,
		groups = def.groups or {cracky = 1, level = 2},
		sounds = def.sounds,
	})
end

function ores.register_19(one, nine)
	minetest.register_craft({
		output = nine .. " 9",
		recipe = {{one}}
	})

	minetest.register_craft({
		output = one,
		recipe = {
			{nine, nine, nine},
			{nine, nine, nine},
			{nine, nine, nine},
		}
	})
end

function ores.register_metal(name, def)
	if def.lump then
		ores.register_lump(name, def.lump)

		if def.ingot then
			minetest.register_craft({
				type = "cooking",
				output = name .. "_ingot",
				recipe = name .. "_lump",
			})
		end
	end
	
	if def.ingot then
		ores.register_ingot(name, def.ingot)

		if def.block then
			ores.register_19(name .. "_block", name .. "_ingot")
		end
	end
	
	if def.mineral then
		ores.register_mineral(name, def.mineral)
	end

	if def.block then
		def.block.sounds = default.node_sound_metal_defaults()
		ores.register_block(name, def.block)
	end
end

function ores.register_crystal_item(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_craftitem(name .. "_crystal", {
		description = def.description or txt .. "_crystal",
		inventory_image = txt .. "_crystal.png",
		groups = def.groups
	})
end

function ores.register_fragment(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_craftitem(name .. "_crystal_fragment", {
		description = def.description or txt .. "_crystal_fragment",
		inventory_image = txt .. "_crystal_fragment.png",
	})
end

function ores.register_crystal(name, def)
	if def.crystal then
		ores.register_crystal_item(name, def.crystal)
		
		if def.fragment then
			ores.register_19(name .. "_crystal", name .. "_crystal_fragment")
		end
		if def.block then
			ores.register_19(name .. "_block", name .. "_crystal")
		end
	end

	if def.fragment then
		ores.register_fragment(name, def.fragment)
	end

	if def.mineral then
		def.mineral.drop = name .. "_crystal"
		def.mineral.groups = {cracky = 1}
		ores.register_mineral(name, def.mineral)
	end

	if def.block then
		ores.register_block(name, def.block)
	end
end
