-- lib/init.lua 

base_lib = {}

function base_lib.register_19(one, nine)
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

