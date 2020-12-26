-- grasses_api/init.lua

grasses = {}

grasses.on_place = function(name, max, itemstack, placer, pointed_thing)
	-- place a random grass node
	local stack = ItemStack(name .. "_grass_" .. math.random(1, max))
	local ret = minetest.item_place(stack, placer, pointed_thing)
	return ItemStack(name .. "_grass_1 " .. itemstack:get_count() - 
		(1 - ret:get_count()))
end

function grasses.register_grass(name, def)
	local txt = name:gsub(":", "_")
	local _i = def.i and "_" .. def.i or ""
	minetest.register_node(name .. "_grass" .. _i, {
		description = def.description or txt,
		drawtype = "plantlike",
		waving = def.waving or 1,
		visual_scale = def.visual_scale,
		tiles = def.tiles or {txt .. "_grass" .. _i .. ".png"},
		inventory_image = def.inventory_image or txt .. "_grass" .. _i .. ".png",
		wield_image = def.wield_image or txt .. "_grass" .. _i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		drop = def.drop or name .. "_grass" .. (def.i and "_1" or ""),
		groups = def.groups or {snappy = 3, flora = 1, attached_node = 1, 
			flammable = 1, not_in_creative_inventory = def.not_in_creative_inventory},
		sounds = trees.node_sound_leaves_defaults(),
		selection_box = def.selection_box or {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, def.height or -5, 6 / 16},
		},
		on_place = def.on_place
	})
	if def.burntime then
		minetest.register_craft({
			type = "fuel",
			recipe = "base_grasses:" .. name .."_grass" .. _i,
			burntime = def.burntime,
		})
	end
end

function grasses.register_decoration(name, def)
	local txt = name:gsub(":", "_")
	local _i = def.i and "_" .. def.i or ""
	minetest.register_decoration({
		name = name .. "_grass" .. _i,
		deco_type = "simple",
		place_on = def.place_on,
		sidelen = def.sidelen or 16,
		fill_ratio = def.fill_ratio,
		noise_params = def.noise_params,
		biomes = def.biomes or {"base_biomes:grassland"},
		y_max = def.y_max or 31000,
		y_min = def.y_min or 1,
		decoration = def.decoration or name .. "_grass" .. _i,
	})
end

function grasses.register_grass_set(name, def)
	def.first.i = 1
	def.first.burntime = def.first.burntime or 2
	def.first.on_place = def.first.on_place or function(itemstack, placer, 
		pointed_thing)
			return grasses.on_place(name, def.max, itemstack, placer, pointed_thing)
	end
	grasses.register_grass(name, def.first)
	def.other.description = def.other.description or def.first.description
	def.other.height = def.other.height or def.first.height
	def.other.visual_scale = def.other.visual_scale or def.first.visual_scale
	if def.first.groups and not def.other.groups then
		def.other.groups = table.copy(def.first.groups)
		def.other.groups.not_in_creative_inventory = 1
	else
		def.other.not_in_creative_inventory = 1
	end
	for fi = 2, def.max do
		def.other.i = fi
		grasses.register_grass(name, def.other)
	end

	if def.deco then
		grasses.register_decoration(name, def.deco)
	end
end

function grasses.dig_up(pos, node, digger)
	if digger == nil then return end
	local np = {x = pos.x, y = pos.y + 1, z = pos.z}
	local nn = minetest.get_node(np)
	if nn.name == node.name then
		minetest.node_dig(np, nn, digger)
	end
end

