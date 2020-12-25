-- base_sounds/init.lua 

base_sounds = {}

function base_sounds.node_sound_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "", gain = 1.0}
	table.dug = table.dug or
			{name = "base_sounds_dug_node", gain = 0.25}
	table.place = table.place or
			{name = "base_sounds_place_node_hard", gain = 1.0}
	return table
end

