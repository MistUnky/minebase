Beds API
--------

#### can_dig
Checks whether the bed is occupied or not and returns true, if it is. Otherwise
it returns false.
```lua
function beds.can_dig(bed_pos)
bed_pos : Position
return  : Boolean
```

#### check_in_beds
Returns true, if all players are in bed and false otherwise.
```lua
function beds.check_in_beds([players])
players : {Player, Player, ...}
return  : Boolean
```
If players is omitted, the function checks all connected players.

#### destruct_bed
Removes the other node of the bed and the spawn point.
```lua
function beds.destruct_bed(pos)
pos     : Position
```

#### get_other_pos
Returns the position of the other node of the bed.
```lua
function beds.get_other_pos(pos, n)
pos     : Position
n       : Integer ∈ {1, 2}
return  : Position
```
n represents one part of the bed. 1 is the bottom 2 is the top.

#### get_player_in_bed_count
Counts and returns the amount of players laying in bed.
```lua
function beds.get_player_in_bed_count()
return  : Integer
```

#### kick_players
Pushes all players out of bed.
```lua
function beds.kick_players()
```

#### lay_down
Puts the player into the bed or pushes him out.
```lua
function beds.lay_down(player, pos, bed_pos[, state][, skip])
player  : Player
pos     : Position
bed_pos : Position
state   : Boolean
skip    : Boolean
```
If state is false (not nil), the player is pushed out of the bed. Otherwise the
player is put into bed.  
If skip is true, the function doesn't change settings that are irrelevant once
a player left.

#### on_place
Places both nodes of the bed, if it is possible and allowed. Otherwise 
the first node is returned to the inventory.
```lua
function beds.on_place(itemstack, placer, pointed_thing)
itemstack       : ItemStack
placer          : Player
pointed_thing   : PointedThing
```

#### on_rotate
A callback that provides custom behavior for screwdrivers. It returns true, if 
the node was rotated, false otherwise.
```lua
function beds.on_rotate(pos, node, user, _, new_param2)
pos             : Position
node            : Node
user            : Player
_               : (not used)
new_param2      : Byte
return          : Boolean
```

#### on_rightclick
Puts the player into the bed, if possible. It also sets the spawn point, if its
not occupied.
```lua
function beds.on_rightclick(pos, player)
pos     : Position
player  : Player
```

#### register_bed
A function that registers a bed.
```lua
function beds.register_bed(name, def)
name    : Itemname
def     : Table

beds.register_bed("mod:item", {
	-- registeres nodes: "mod:item_bottom", "mod:item_top"
	-- essential 
	tiles = {
		bottom = {Texture, Texture, Texture, Texture, Texture, Texture},
		top = {Texture, Texture, Texture, Texture, Texture, Texture}
	},
	node_box = {
		bottom = Box OR {Box, Box, ...},
		top = Box OR {Box, Box, ...}
	},

	-- optional
	description = "mod_item"
	short_description = ?,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, 
		bed = 1},
	inventory_image = "mod_item_inventory.png",
	inventory_overlay = nil,
	wield_image = "mod_item_inventory.png",
	wield_overlay = nil,
	palette = nil,
	color = nil,
	wield_scale = 1,
	range = ?,
	liquids_pointable = false,
	node_placement_prediction = nil,
	node_dig_prediction = nil,
	sound = nil,
	on_place = beds.on_place,
	on_secondary_use = def.on_secondary_use,
	on_drop = def.on_drop,
	on_use = def.on_use,
	after_use = def.after_use,
	overlay_tiles = nil,
	selection_box = Box,
	collision_box = Box,
	sounds = sounds.get_defaults("tree_sounds:wood"),
	drop = nil,
	on_construct = nil,
	on_destruct = beds.destruct_bed,
	after_destruct = nil,
	after_place_node = nil,
	after_dig_node = nil,
	can_dig = can_dig,
	on_punch = nil,
	on_rightclick = on_rightclick,
	on_dig = nil,
	on_timer = nil,
	on_blast = nil,
	on_rotate = beds.on_rotate,
	_base_name = name
	recipe = nil,

	-- fixed
	stack_max = 1,
	drawtype = "nodebox",
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,

	-- fixed (second node)
	drop = "mod:item_bottom",
	pointable = false,
})
```

#### remove_spawns_at
Removes spawn points.
```lua
function beds.remove_spawns_at(pos)
pos     : Position
```

#### set_spawn
Sets and saves the spawn for a player.
```lua
function beds.set_spawn(name, pos)
name    : String
pos     : Position
```

#### skip_night
Skips over the night.
```lua
function beds.skip_night()
```

