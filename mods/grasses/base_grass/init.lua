-- base_grasses/init.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("base_grasses")

minetest.register_node("base_grasses:junglegrass", {
	description = S("Jungle Grass"),
	visual_scale = 1.69,
	tiles = {"base_grasses_junglegrass.png"},
	inventory_image = "base_grasses_junglegrass.png",
	wield_image = "base_grasses_junglegrass.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
})

--[[
minetest.register_node("base_grasses:grass_1", {
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, flammable = 1},
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random grass node
		local stack = ItemStack("base_grasses:grass_" .. math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("base_grasses:grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})
--]]

grasses.register_grass("base_grasses:common", {
	description = S("Grass"),
	height = -3,
	max = 5
})

minetest.register_node("base_grasses:dry_grass_1", {
	description = S("Savanna Grass"),
	tiles = {"base_grasses_dry_grass_1.png"},
	inventory_image = "base_grasses_dry_grass_3.png",
	wield_image = "base_grasses_dry_grass_3.png",
	groups = {snappy = 3, flammable = 3, flora = 1,
		attached_node = 1, dry_grass = 1},
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random dry grass node
		local stack = ItemStack("base_grasses:dry_grass_" .. math.random(1, 5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("base_grasses:dry_grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 5 do
	minetest.register_node("base_grasses:dry_grass_" .. i, {
		description = S("Savanna Grass"),
		tiles = {"base_grasses_dry_grass_" .. i .. ".png"},
		inventory_image = "base_grasses_dry_grass_" .. i .. ".png",
		wield_image = "base_grasses_dry_grass_" .. i .. ".png",
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
			not_in_creative_inventory=1, dry_grass = 1},
		drop = "base_grasses:dry_grass_1",
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -1 / 16, 6 / 16},
		},
	})
end


minetest.register_node("base_grasses:fern_1", {
	description = S("Fern"),
	tiles = {"base_grasses_fern_1.png"},
	inventory_image = "base_grasses_fern_1.png",
	wield_image = "base_grasses_fern_1.png",
	groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1},
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random fern node
		local stack = ItemStack("base_grasses:fern_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("base_grasses:fern_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 3 do
	minetest.register_node("base_grasses:fern_" .. i, {
		description = S("Fern"),
		visual_scale = 2,
		tiles = {"base_grasses_fern_" .. i .. ".png"},
		inventory_image = "base_grasses_fern_" .. i .. ".png",
		wield_image = "base_grasses_fern_" .. i .. ".png",
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
			not_in_creative_inventory=1},
		drop = "base_grasses:fern_1",
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
end

minetest.register_node("base_grasses:marram_grass_1", {
	description = S("Marram Grass"),
	tiles = {"base_grasses_marram_grass_1.png"},
	inventory_image = "base_grasses_marram_grass_1.png",
	wield_image = "base_grasses_marram_grass_1.png",
	groups = {snappy = 3, flammable = 3, attached_node = 1},
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random marram grass node
		local stack = ItemStack("base_grasses:marram_grass_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("base_grasses:marram_grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 3 do
	minetest.register_node("base_grasses:marram_grass_" .. i, {
		description = S("Marram Grass"),
		tiles = {"base_grasses_marram_grass_" .. i .. ".png"},
		inventory_image = "base_grasses_marram_grass_" .. i .. ".png",
		wield_image = "base_grasses_marram_grass_" .. i .. ".png",
		groups = {snappy = 3, flammable = 3, attached_node = 1,
			not_in_creative_inventory=1},
		drop = "base_grasses:marram_grass_1",
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
end

minetest.register_node("base_grasses:papyrus", {
	description = S("Papyrus"),
	drawtype = "plantlike",
	tiles = {"base_grasses_papyrus.png"},
	inventory_image = "base_grasses_papyrus.png",
	wield_image = "base_grasses_papyrus.png",
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2},

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

