Carts 
------
#### check_front_up_down
Determines whether the rail of railtype is leading the cart up, forward or down.
It returns a vector with the new direction.
```lua
function carts.check_front_up_down(pos, dir, check_up, railtype)
pos             : Position
dir             : Vector
check_up        : Boolean
railtype        : GroupName
return          : Vector
```
If check_up is true, the function checks a possible rise, otherwise it is not.
It always checks for a drop or no height change.  
railtype is a group name assigned to connect_to_raillike in the groups 
attribute of rails.

#### craftitem_on_place
Places a cart on a rail node. In case of success returns an ItemStack with one 
cart less (unless you are in creative mode).
```lua
function carts.craftitem_on_place(itemstack, placer, pointed_thing)
itemstack       : ItemStack
placer          : Player
pointed_thing   : PointedThing
return          : ItemStack
```

#### get_rail_direction
Determines the direction a cart is going to take at a junction.
```lua
function carts.get_rail_direction(entity, pos, dir, ctrl, old_switch, railtype)
entity          : LuaEntity
pos             : Position
dir             : Vector
ctrl            : PlayerControls
old_switch      : Mixed ∈ {nil, 1, 2}
railtype        : GroupName
return          : Vector
```
old_switch disables the possibility to turn left (1) or right (2) or it has no 
effect.

#### get_rail_groups
Adds rail groups to a given groups table or returns a new table with rail 
groups.
```lua
function carts.get_rail_groups(groups)
groups  : Groups
return  : Groups
```

#### get_sign
Takes a number and returns a number representing the sign.
```lua
function carts.get_sign(z)
z       : Number
return  : x ∈ {-1, 0, 1}
```

#### get_staticdata
Returns a string representing attributes of the entity. It is used by the engine 
to save keep them over multiple instances. Every time the area is loaded a new
instance is created.
```lua
function carts.get_staticdata(entity)
entity  : LuaEntity
return  : Serialized
```

#### is_rail
Returns true if, the node in position pos is a rail node and false otherwise.
```lua
function carts.is_rail(pos[, railtype])
pos             : Position
railtype        : GroupName
return          : Boolean
```
If railtype is provided, it also checks the type of the rail.

#### on_activate
#### on_punch
#### on_step
#### pathfinder
#### rail_on_step
#### rail_sound
#### register_cart
#### register_craftitem
#### register_entity
#### register_rail
#### velocity_to_dir
