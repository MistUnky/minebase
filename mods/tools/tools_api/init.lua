-- tools_api/init.lua

--
-- Crafting (tool repair)
--

minetest.register_craft({
	type = "toolrepair",
	additional_wear = -0.02,
})

tools = {}

function tools.register_pickaxe(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_tool(name .. "_pickaxe", {
		description = def.description,
		inventory_image = def.inventory_image or txt .. "_pickaxe.png",
		tool_capabilities = def.tool_capabilities or {
			full_punch_interval = 1.2,
			max_drop_level=0,
			groupcaps={
				cracky = {times={3.2, 1.5, 0.9}, uses=10, maxlevel=1},
			},
			damage_groups = {fleshy=2},
		},
		sound = {breaks = "tools_api_breaks"},
		groups = def.groups or {pickaxe = 1}
	})

	minetest.register_craft({
		output = name .. "_pickaxe",
		recipe = {
			{def.material, def.material, def.material},
			{"", "group:stick", ""},
			{"", "group:stick", ""}
		}
	})
end

function tools.register_shovel(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_tool(name .. "_shovel", {
		description = def.description,
		inventory_image = def.inventory_image or txt .. "_shovel.png",
		wield_image = def.wield_image or txt .. "_shovel.png^[transformR90",
		tool_capabilities = def.tool_capabilities or {
			full_punch_interval = 1.2,
			max_drop_level=0,
			groupcaps={
				crumbly = {times={1.7, 1.0, 0.4}, uses=10, maxlevel=1},
			},
			damage_groups = {fleshy=2},
		},
		sound = {breaks = "tools_api_breaks"},
		groups = def.groups or {shovel = 1}
	})

	minetest.register_craft({
		output = name .. "_shovel",
		recipe = {
			{def.material},
			{"group:stick"},
			{"group:stick"}
		}
	})
end

function tools.register_axe(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_tool(name .."_axe", {
		description = def.description,
		inventory_image = def.inventory_image or txt .. "_axe.png",
		tool_capabilities = def.tool_capabilities or {
			full_punch_interval = 1.0,
			max_drop_level=0,
			groupcaps={
				choppy = {times={2.5, 1.7, 1.0}, uses=10, maxlevel=1},
			},
			damage_groups = {fleshy=2},
		},
		sound = {breaks = "tools_api_breaks"},
		groups = {axe = 1}
	})

	minetest.register_craft({
		output = name .. "_axe",
		recipe = {
			{def.material, def.material},
			{def.material, "group:stick"},
			{"", "group:stick"}
		}
	})
end

function tools.register_sword(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_tool(name .. "_sword", {
		description = def.description,
		inventory_image = def.inventory_image or txt .. "_sword.png",
		tool_capabilities = def.tool_capabilities or {
			full_punch_interval = 1,
			max_drop_level=0,
			groupcaps={
				snappy={times={2.3, 1.2, 0.4}, uses=10, maxlevel=1},
			},
			damage_groups = {fleshy=2},
		},
		sound = {breaks = "tools_api_breaks"},
		groups = {sword = 1}
	})

	minetest.register_craft({
		output = name .. "_sword",
		recipe = {
			{def.material},
			{def.material},
			{"group:stick"}
		}
	})
end

function tools.register_set(name, def)
	if def.material then 
		def.pickaxe.material = def.material
		def.shovel.material = def.material
		def.axe.material = def.material
		def.sword.material = def.material
	end

	tools.register_pickaxe(name, def.pickaxe)
	tools.register_shovel(name, def.shovel)
	tools.register_axe(name, def.axe)
	tools.register_sword(name, def.sword)
end
