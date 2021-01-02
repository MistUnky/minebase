-- walls/init.lua

walls = {}

local fence_collision_extra = minetest.settings:get_bool("enable_fence_tall") and 3/8 or 0

-- Load support for Minebase translation.
local S = minetest.get_translator("walls")

walls.register = function(wall_name, wall_desc, wall_texture_table, wall_mat, wall_sounds)
	--make wall_texture_table paramenter backwards compatible for mods passing single texture
	if type(wall_texture_table) ~= "table" then
		wall_texture_table = { wall_texture_table }
	end
	-- inventory node, and pole-type wall start item
	minetest.register_node(wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		node_box = {
			type = "connected",
			fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
			-- connect_bottom =
			connect_front = {-3/16, -1/2, -1/2,  3/16, 3/8, -1/4},
			connect_left = {-1/2, -1/2, -3/16, -1/4, 3/8,  3/16},
			connect_back = {-3/16, -1/2,  1/4,  3/16, 3/8,  1/2},
			connect_right = { 1/4, -1/2, -3/16,  1/2, 3/8,  3/16},
		},
		collision_box = {
			type = "connected",
			fixed = {-1/4, -1/2, -1/4, 1/4, 1/2 + fence_collision_extra, 1/4},
			-- connect_top =
			-- connect_bottom =
			connect_front = {-1/4,-1/2,-1/2,1/4,1/2 + fence_collision_extra,-1/4},
			connect_left = {-1/2,-1/2,-1/4,-1/4,1/2 + fence_collision_extra,1/4},
			connect_back = {-1/4,-1/2,1/4,1/4,1/2 + fence_collision_extra,1/2},
			connect_right = {1/4,-1/2,-1/4,1/2,1/2 + fence_collision_extra,1/4},
		},
		connects_to = { "group:wall", "group:stone", "group:fence" },
		paramtype = "light",
		is_ground_content = false,
		tiles = wall_texture_table,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2 },
		sounds = wall_sounds,
	})

	-- crafting recipe
	minetest.register_craft({
		output = wall_name .. " 6",
		recipe = {
			{ "", "", "" },
			{ wall_mat, wall_mat, wall_mat},
			{ wall_mat, wall_mat, wall_mat},
		}
	})

end

walls.register("walls:stone_cobble", S("Cobblestone Wall"), 
	{"base_earth_stone_cobble.png"}, "base_earth:stone_cobble", 
	earth.node_sound_stone_defaults())

walls.register("walls:mossy_stone_cobble", S("Mossy Cobblestone Wall"), 
	{"mossy_stone_cobble.png"},	"mossy:stone_cobble", 
	earth.node_sound_stone_defaults())

walls.register("walls:desert_stone_cobble", S("Desert Cobblestone Wall"), 
	{"base_earth_desert_stone_cobble.png"}, "base_earth:desert_stone_cobble", 
	earth.node_sound_stone_defaults())

mossy.register_growth("walls:mossy", {
	nodenames = {"walls:stone_cobble"},
	map = {
		["walls:stone_cobble"] = "walls:mossy_stone_cobble",
	}
})
