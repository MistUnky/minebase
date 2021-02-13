-- boats/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("boats")

lib_mount.register_mount("boats:boat", {
	entity = {
		terrain_type = 2,
		max_speed_forward = 3,
		max_speed_reverse = 3,
		accel = 3,
		braking = 3,
		turn_speed = 3,
		stepheight = 0,
		visual = "mesh",
		mesh = "boats_boat.obj",
		visual_size = {x=1, y=1},
		wield_scale = {x=1, y=1, z=1},
		collisionbox = {-0.5, -0.35, -0.5, 0.5, 0.3, 0.5},
		textures = {"base_trees_apple_wood.png"},
		player_rotation = {x=0, y=0, z=0},
		drop_on_destroy = {"default:wood 3"},
		driver_attach_at = {x=0.5,y=1,z=-3},
		driver_eye_offset = {x=0, y=0, z=0},
		number_of_passengers = 0,
		passenger_attach_at = {x=0,y=0,z=0},
		passenger_eye_offset = {x=0, y=0, z=0},
		passenger2_attach_at = {x=0,y=0,z=0},
		passenger2_eye_offset = {x=0, y=0, z=0},
		passenger3_attach_at = {x=0,y=0,z=0},
		passenger3_eye_offset = {x=0, y=0, z=0}
	},
	craftitem = {
		description = S("Boat"),
		wield_scale = {x = 2, y = 2, z = 1},
		groups = {flammable = 2},
		recipe = {
			{"",           "",           ""          },
			{"group:wood", "",           "group:wood"},
			{"group:wood", "group:wood", "group:wood"},
		},
		burntime = 20,
		onplace_position_adj = 0,
	}
})
