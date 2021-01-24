-- liquid_sounds/init.lua

sounds.register_defaults("liquid_sounds:ice", {
	footstep = {name = "liquids_sounds_ice_footstep", gain = 0.3},
	dig = {name = "liquids_sounds_ice_dig", gain = 0.5},
	dug = {name = "liquids_sounds_ice_dug", gain = 0.5}
})

sounds.register_defaults("liquid_sounds:water", {
	footstep = {name = "liquids_sounds_water_footstep", gain = 0.2}
})

sounds.register_defaults("liquid_sounds:snow", {
	footstep = {name = "liquids_sounds_snow_footstep", gain = 0.2},
	dig = {name = "liquids_sounds_snow_footstep", gain = 0.3},
	dug = {name = "liquids_sounds_snow_footstep", gain = 0.3},
	place = {name = "base_sounds_place_node", gain = 1.0}
})

