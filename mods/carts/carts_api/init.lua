-- carts_api/init.lua

carts = {}
carts.railparams = {}

-- Maximal speed of the cart in m/s (min = -1)
carts.speed_max = 7
-- Set to -1 to disable punching the cart from inside (min = -1)
carts.punch_speed_max = 5
-- Maximal distance for the path correction (for dtime peaks)
carts.path_distance_max = 3

function carts:get_sign(z)
	if z == 0 then
		return 0
	else
		return z / math.abs(z)
	end
end

function carts:manage_attachment(player, obj)
	if not player then
		return
	end
	local status = obj ~= nil
	local player_name = player:get_player_name()
	if players.player_attached[player_name] == status then
		return
	end
	players.player_attached[player_name] = status

	if status then
		player:set_attach(obj, "", {x=0, y=-4.5, z=0}, {x=0, y=0, z=0})
		player:set_eye_offset({x=0, y=-4, z=0},{x=0, y=-4, z=0})
	else
		player:set_detach()
		player:set_eye_offset({x=0, y=0, z=0},{x=0, y=0, z=0})
	end
end

function carts:velocity_to_dir(v)
	if math.abs(v.x) > math.abs(v.z) then
		return {x=carts:get_sign(v.x), y=carts:get_sign(v.y), z=0}
	else
		return {x=0, y=carts:get_sign(v.y), z=carts:get_sign(v.z)}
	end
end

function carts:is_rail(pos, railtype)
	local node = minetest.get_node(pos).name
	if node == "ignore" then
		local vm = minetest.get_voxel_manip()
		local emin, emax = vm:read_from_map(pos, pos)
		local area = VoxelArea:new{
			MinEdge = emin,
			MaxEdge = emax,
		}
		local data = vm:get_data()
		local vi = area:indexp(pos)
		node = minetest.get_name_from_content_id(data[vi])
	end
	if minetest.get_item_group(node, "rail") == 0 then
		return false
	end
	if not railtype then
		return true
	end
	return minetest.get_item_group(node, "connect_to_raillike") == railtype
end

function carts:check_front_up_down(pos, dir_, check_up, railtype)
	local dir = vector.new(dir_)
	local cur

	-- Front
	dir.y = 0
	cur = vector.add(pos, dir)
	if carts:is_rail(cur, railtype) then
		return dir
	end
	-- Up
	if check_up then
		dir.y = 1
		cur = vector.add(pos, dir)
		if carts:is_rail(cur, railtype) then
			return dir
		end
	end
	-- Down
	dir.y = -1
	cur = vector.add(pos, dir)
	if carts:is_rail(cur, railtype) then
		return dir
	end
	return nil
end

function carts:get_rail_direction(pos_, dir, ctrl, old_switch, railtype)
	local pos = vector.round(pos_)
	local cur
	local left_check, right_check = true, true

	-- Check left and right
	local left = {x=0, y=0, z=0}
	local right = {x=0, y=0, z=0}
	if dir.z ~= 0 and dir.x == 0 then
		left.x = -dir.z
		right.x = dir.z
	elseif dir.x ~= 0 and dir.z == 0 then
		left.z = dir.x
		right.z = -dir.x
	end

	local straight_priority = ctrl and dir.y ~= 0

	-- Normal, to disallow rail switching up- & downhill
	if straight_priority then
		cur = self:check_front_up_down(pos, dir, true, railtype)
		if cur then
			return cur
		end
	end

	if ctrl then
		if old_switch == 1 then
			left_check = false
		elseif old_switch == 2 then
			right_check = false
		end
		if ctrl.left and left_check then
			cur = self:check_front_up_down(pos, left, false, railtype)
			if cur then
				return cur, 1
			end
			left_check = false
		end
		if ctrl.right and right_check then
			cur = self:check_front_up_down(pos, right, false, railtype)
			if cur then
				return cur, 2
			end
			right_check = true
		end
	end

	-- Normal
	if not straight_priority then
		cur = self:check_front_up_down(pos, dir, true, railtype)
		if cur then
			return cur
		end
	end

	-- Left, if not already checked
	if left_check then
		cur = carts:check_front_up_down(pos, left, false, railtype)
		if cur then
			return cur
		end
	end

	-- Right, if not already checked
	if right_check then
		cur = carts:check_front_up_down(pos, right, false, railtype)
		if cur then
			return cur
		end
	end

	-- Backwards
	if not old_switch then
		cur = carts:check_front_up_down(pos, {
				x = -dir.x,
				y = dir.y,
				z = -dir.z
			}, true, railtype)
		if cur then
			return cur
		end
	end

	return {x=0, y=0, z=0}
end

function carts:pathfinder(pos_, old_pos, old_dir, distance, ctrl,
		pf_switch, railtype)

	local pos = vector.round(pos_)
	if vector.equals(old_pos, pos) then
		return
	end

	local pf_pos = vector.round(old_pos)
	local pf_dir = vector.new(old_dir)
	distance = math.min(carts.path_distance_max,
		math.floor(distance + 1))

	for i = 1, distance do
		pf_dir, pf_switch = self:get_rail_direction(
			pf_pos, pf_dir, ctrl, pf_switch or 0, railtype)

		if vector.equals(pf_dir, {x=0, y=0, z=0}) then
			-- No way forwards
			return pf_pos, pf_dir
		end

		pf_pos = vector.add(pf_pos, pf_dir)

		if vector.equals(pf_pos, pos) then
			-- Success! Cart moved on correctly
			return
		end
	end
	-- Not found. Put cart to predicted position
	return pf_pos, pf_dir
end

function carts:get_rail_groups(groups)
	groups = groups and table.copy(groups) or {dig_immediate = 2}
	groups.attached_node = 1
	groups.rail = 1
	groups.connect_to_raillike = minetest.raillike_group("rail")
	return groups
end

function carts:register_rail(name, def)
	if def.railparams then
		carts.railparams[name] = table.copy(def.railparams)
	end

	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description,
		tiles = def.tiles or {
			txt .. "_straight.png", txt .. "_curved.png",
			txt .. "_t_junction.png", txt .. "_crossing.png"
		},
		groups = carts:get_rail_groups(def.groups),
		drawtype = "raillike",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		walkable = def.walkable or false,
		wield_image = def.wield_image or txt .. "_straight.png",
		inventory_image = def.inventory_image or txt .. "_straight.png",
		selection_box = def.selection_box or {
			type = "fixed",
			fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
		},
		sounds = def.sounds or ores.node_sound_metal_defaults()
	})

	if def.recipe then
		minetest.register_craft({
			output = name .. " 18",
			recipe = def.recipe 
		})
	end
end

