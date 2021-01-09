-- env_sounds_api/init.lua


env_sounds = {radius = 8, allsounds = {}, cache_triggers = {}}

function env_sounds.register_sound(name, def)
	env_sounds.allsounds[name] = {
		trigger = def.trigger,
		base_volume = def.base_volume or 0.04,
		max_volume = def.max_volume or 0.4,
		per_node = def.per_node or 0.004,
	}
	for _, trigger in ipairs(def.trigger) do
		table.insert(env_sounds.cache_triggers, trigger)
	end
end

function env_sounds.update_sound(player)
	local player_name = player:get_player_name()
	local ppos = player:get_pos()
	ppos = vector.add(ppos, player:get_properties().eye_height)
	local areamin = vector.subtract(ppos, env_sounds.radius)
	local areamax = vector.add(ppos, env_sounds.radius)

	local pos = minetest.find_nodes_in_area(areamin, areamax, 
		env_sounds.cache_triggers, true)
	if next(pos) == nil then -- If table empty
		return
	end
	for sound, def in pairs(env_sounds.allsounds) do
		-- Find average position
		local posav = {0, 0, 0}
		local count = 0
		for _, name in ipairs(def.trigger) do
			if pos[name] then
				for _, p in ipairs(pos[name]) do
					posav[1] = posav[1] + p.x
					posav[2] = posav[2] + p.y
					posav[3] = posav[3] + p.z
				end
				count = count + #pos[name]
			end
		end

		if count > 0 then
			posav = vector.new(posav[1] / count, posav[2] / count,
				posav[3] / count)

			-- Calculate gain
			local gain = def.base_volume
			if type(def.per_node) == 'table' then
				for name, multiplier in pairs(def.per_node) do
					if pos[name] then
						gain = gain + #pos[name] * multiplier
					end
				end
			else
				gain = gain + count * def.per_node
			end
			gain = math.min(gain, def.max_volume)

			minetest.sound_play(sound, {
				pos = posav,
				to_player = player_name,
				gain = gain,
			}, true)
		end
	end
end

-- Update sound when player joins

minetest.register_on_joinplayer(function(player)
	env_sounds.update_sound(player)
end)

-- Cyclic sound update

function env_sounds.cyclic_update()
	for _, player in pairs(minetest.get_connected_players()) do
		env_sounds.update_sound(player)
	end
	minetest.after(3.5, env_sounds.cyclic_update)
end

minetest.after(0, env_sounds.cyclic_update)
