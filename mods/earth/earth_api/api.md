Earth 
------
#### define_defaults
```lua
function earth.define_default(def)
def     : EarthDefaults

EarthDefaults {
	stone = Name
}

```

#### register_block
```lua
```
#### register_brick
Registers a brick node.
```lua
function earth.register_brick(name, def)
name    : Name
def     : BrickDef

earth.register_brick("mod:node", {
	-- essential

	-- optional
	description = "mod_node"
	short_description = "",
	groups = {cracky = 2},
	palette = nil,
	color = nil,
	stack_max = 100,
	range = 4,
	light_source = 0,
	node_placement_prediction = nil,
	node_dig_prediction = "air",
	sound = nil,
	tiles = {"mod_node_brick.png"},
	overlay_tiles = nil,
	special_tiles = nil,
	use_texture_alpha = false,
	post_effect_color = nil,
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = true,
	walkable = true, 
	diggable = true,
	leveled = nil,
	leveled_max = nil,
	sounds = sounds.get_defaults("earth_sounds:stone")
	drop = nil,
})

```
#### register_cobble
```lua
```
#### register_deco
```lua
```
#### register_node_with
```lua
```
#### register_nodes_with
```lua
```
#### register_ore
```lua
```
#### register_sand
```lua
```
#### register_sand_nodes
```lua
```

#### register_stone
Registers a stone node.
```lua
function earth.register_stone(name, def)
name    : Name
def     : StoneDef

earth.register_stone("mod:node", {
	-- essential

	-- optional
	description = "mod_node",
	short_description = "",
	groups = {cracky = 3},
	palette = nil,
	color = nil,
	stack_max = 100,
	range = 4,
	light_source = 0,
	node_placement_prediction = nil,
	node_dig_prediction = "air",
	sound = nil,
	tiles = {"mod_node.png"},
	overlay_tiles = nil,
	special_tiles = nil,
	use_texture_alpha = "opaque",
	post_effect_color = nil,
	is_ground_content = true,
	walkable = true, 
	diggable = true,
	leveled = nil,
	leveled_max = nil,
	sounds = sounds.get_defaults("earth_sounds:stone")
	drop = nil,
})

```
#### register_stone_nodes
```lua
```
