
Containers 
------
#### close
Closes an open container.
```lua
function containers.close(name)
name    : Name
```

#### create_formspec
```lua
function containers.create_formspec(inventory1, def)
inventory1      : Name
def             : Table
return          : Formspec

containers.create_formspec("main", {
	-- optional
	width = 8,
	height = 9,
	list1 = "main",
	x1 = 0, 
	y1 = 0.3,
	inventory1_width = 8, 
	inventory1_height = 4,
	x2 = 0, 
	y2 = 4.85,
	x2 = 0,
	y2 = 6.08,
	overlay = ""
})

```
#### lid_obstructed
Returns true, if something is blocking the lid from opening and false otherwise.
```lua
function containers.lid_obstructed(pos)
pos     : Position
return  : Boolean
```

#### on_blast
```lua
```
#### on_construct
```lua
```
#### on_key_use
```lua
```
#### on_metadata_inventory_move
```lua
```
#### on_metadata_inventory_put
```lua
```
#### on_metadata_inventory_take
```lua
```
#### on_rightclick
```lua
```
#### on_rightclick
```lua
```
#### on_skeleton_key_use
```lua
```
#### protected
```lua
```
#### register_container
```lua
```
#### unprotected
```lua
```

containers.protected
--------------------

#### protected.after_place_node
Sets the owner of a protected container after it was placed.
```lua
function containers.protected.after_place_node(pos, placer)
pos     : Position
placer  : Player
```

#### protected.allow_metadata_inventory_move
Returns the amount of items the player is allowed to move within a protected 
container. 
```lua
function containers.protected.allow_metadata_inventory_move(pos, _, _, _ , _, 
	count, player)
pos     : Position
_       : Mixed
count   : Integer
player  : Player
return  : Integer
```

#### protected.allow_metadata_inventory_put
Returns the amount of items the player is allowed to put into a protected 
container.
```lua
function containers.protected.allow_metadata_inventory_put(pos, _, _, stack, 
	player)
pos     : Position
_       : Mixed
stack   : ItemStack
player  : Player
return  : Integer
```

#### protected.allow_metadata_inventory_take
Returns the amount of items the player is allowed to take from a protected
container.
```lua
function containers.protected.allow_metadata_inventory_take(pos, _, _, stack, 
	player)
pos     : Position
_       : Mixed
stack   : ItemStack
player  : Player
return  : Integer
```

#### protected.can_dig
Returns true, if the player is allowed to dig the protected container, false 
otherwise.
```lua
function containers.protected.can_dig(pos, player)
pos     : Position
player  : Player
return  : Boolean
```

#### protected.on_blast
Does nothing. Protected containers are not blown up.
```lua
function containers.protected.on_blast()
```

#### protected.on_construct
Sets the owner of a placed protected container and sets up the inventory.
```lua
function containers.protected.on_construct(pos)
pos     : Position
```

containers.unprotected
----------------------

#### unprotected.allow_metadata_inventory_put
Returns the amount of items the player is allowed to put into an unprotected 
container.
```lua
function containers.unprotected.allow_metadata_inventory_put(pos, _, _, stack)
pos     : Position
_       : Mixed
stack   : ItemStack
return  : Integer
```

#### unprotected.can_dig
Returns true, if the player is allowed to dig the unprotected container, false 
otherwise.
```lua
function containers.unprotected.can_dig(pos, player)
pos     : Position
player  : Player 
return  : Boolean
```
