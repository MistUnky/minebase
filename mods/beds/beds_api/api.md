Beds API
--------

Returns the position of the other node of the bed.
```txt
function beds.get_other_pos(pos, n)
pos     : Position
n       : Integer ∈ {1, 2}
return  : Position

n represents one part of the bed. 1 is the bottom 2 is the top.
```

Removes the other node of the bed and the spawn point.
```txt
function beds.destruct_bed(pos)
pos     : Position
```

Places the both nodes of the bed, if it is possible and allowed. Otherwise 
the first node is returned to the inventory.
```txt
function beds.on_place(itemstack, placer, pointed_thing)
itemstack       : ItemStack
placer          : Player
pointed_thing   : PointedThing
```

A callback that provides custom behavior for screwdrivers.
```txt
function beds.on_rotate(pos, node, user, _, new_param2)
pos             : Position
node            : Node
user            : Player
_               : (not used)
new_param2      : Byte
```

```txt
function beds.register_bed(name, def)
name    : Itemname
def     : Table

beds.register_bed("mod:item", {
	-- registered nodes: "mod:item_bottom", "mod:item_top"
	-- essential 
	node_box = {
		bottom = {%f, %f, %f, %f, %f, %f},
		top = {%f, %f, %f, %f, %f, %f}
	},
	tiles = {
		bottom = {%s, %s, %s, %s, %s, %s},
		top = {%s, %s, %s, %s, %s, %s}
	},

	-- optional
	description = "mod_item"
	inventory_image = "mod_item_inventory.png",
	wield_image = "mod_item_inventory.png",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, 
		bed = 1},
	sounds = sounds.get_defaults("tree_sounds:wood"),
	recipe = nil,
	selection_box = {%f, %f, %f, %f, %f, %f},
	on_place = beds.on_place,
	on_destruct = beds.destruct_bed,
	on_rightclick = on_rightclick,
	on_rotate = beds.on_rotate,
	can_dig = can_dig,

	-- fixed
	drawtype = "nodebox",
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	stack_max = 1,

	-- fixed (second node)
	drop = "mod:item_bottom",
	pointable = false,
})
```

TODO:
beds/beds_api/api.lua
    .get_other_pos,			dc
    .destruct_bed,			m
    .on_place,				mc
    .on_rotate,				mc
    .register_bed,			m

beds/beds_api/functions.lua 
    .check_in_beds,			dc
    .lay_down,				m
    .get_player_in_bed_count,		dc
    .kick_players,			m
    .skip_night,			m
    .on_rightclick,			m
    .can_dig,				dc

beds/beds_api/spawn.lua
    .read_spawns,			m rw
    .save_spawns,			m w
    .set_spawns,			m
    .remove_spawns_at,			m


