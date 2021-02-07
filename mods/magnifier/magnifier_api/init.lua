-- magnifier_api/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("magnifier_api")
magnifier = {registered = {}}

function magnifier.update_fov(player, new_zoom_fov)
	if minetest.is_creative_enabled(player:get_player_name()) then
		new_zoom_fov = new_zoom_fov + 5
	end

	-- Only set property if necessary to avoid player mesh reload
	if player:get_properties().zoom_fov ~= new_zoom_fov then
		player:set_properties({zoom_fov = new_zoom_fov})
	end
end

function magnifier.update_player_property(itemstack, player)
	itemstack = itemstack or player:get_wielded_item()

	if itemstack then
		local name = itemstack:get_name()
		for _, registered_name in ipairs(magnifier.registered) do
			if name == registered_name then
				minetest.after(4.7, magnifier.update_player_property, nil, player)
				return magnifier.update_fov(player, itemstack:get_definition().zoom_fov)
			end
		end
	end
	magnifier.update_fov(player, 0)
end

function magnifier.register_magnifier(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_craftitem(name, {
		description = (def.description  or name) .. "\n" 
			.. S("Use with 'Zoom' key"),
		inventory_image = def.inventory_image or txt .. ".png",
		wield_image = def.wield_image or txt .. ".png",
		stack_max = 1,
		on_use = def.on_use or magnifier.update_player_property,
		on_secondary_use = def.on_secondary_use,
		on_place = def.on_place,
		on_drop = def.on_drop,
		after_use = def.after_use,
		zoom_fov = def.zoom_fov or 10
	})
	table.insert(magnifier.registered, name)

	if def.recipe then
		minetest.register_craft({
			output = name,
			recipe = def.recipe
		})
	end
end

minetest.register_on_joinplayer(function(player)
	magnifier.update_player_property(nil, player)
end)

