-- base_api/init.lua 

base = {}

function base.register_craft14(one, four)
	minetest.register_craft({
		output = four .. " 4",
		recipe = {{one}}
	})

	minetest.register_craft({
		output = one,
		recipe = {
			{four, four},
			{four, four},
		}
	})
end

function base.register_craft44(four1, four2)
	minetest.register_craft({
		output = four1 .. " 4",
		recipe = {
			{four2, four2},
			{four2, four2}
		}
	})

	minetest.register_craft({
		output = four2 .. " 4",
		recipe = {
			{four1, four1},
			{four1, four1}
		}
	})
end

function base.register_craft19(one, nine)
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

function base.register_craft99(one, nine)
	minetest.register_craft({
		output = nine .. " 9",
		recipe = {{one}}
	})

	minetest.register_craft({
		output = one .. " 9",
		recipe = {
			{nine, nine, nine},
			{nine, nine, nine},
			{nine, nine, nine},
		}
	})
end

function base.get_inventory_drops(pos, inventory, drops)
	local inv = minetest.get_meta(pos):get_inventory()
	local n = #drops
	for i = 1, inv:get_size(inventory) do
		local stack = inv:get_stack(inventory, i)
		if stack:get_count() > 0 then
			drops[n+1] = stack:to_table()
			n = n + 1
		end
	end
end

