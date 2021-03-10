Biomes 
------

#### define_default
Sets provided nodes as default values for the biomes.
```lua
function biomes.define_default(def)
def     : Table

function biomes.define_default({
	-- fixed 
	sand = Itemname,
	stone_cobble = Itemname,
	mossy_stone_cobble = Itemname,
	water = Itemname,
	lava = Itemname,
	stone_cobble_stair = Itemname,
})
```

#### register_biome
Registers a new biome.
```lua
function biomes.register_biome(name, def)
name    : Itemname
def     : Table

function biomes.register_biome(name, {
	-- essential
	name = name,

	-- optional
	depth_top = 1,
	depth_filler = 3,
	node_riverbed = biomes.sand,
	depth_riverbed = 2,
	node_dungeon = biomes.stone_cobble,
	node_dungeon_alt = biomes.mossy_stone_cobble,
	node_dungeon_stair = biomes.stone_cobble_stair,
	y_max = not def.max_pos and 31000 or nil,
	y_min = not def.min_pos and 1 or nil,
	max_pos = nil,
	min_pos = nil,
	vertical_blend = 0,
	heat_point = 50,
	humidity_point = 50,
	node_dust = ?,
	node_top = ?,
	node_filler = ?,
	node_stone = ?,
	node_water_top = ?,
	depth_water_top = ?,
	node_water = ?,
	node_river_water = ?,
	node_cave_liquid = ?,
})
```
You should only use y_min and y_max or min_pos and max_pos, but not both.

#### register_biome_set
#### register_ocean
#### register_stratum
#### register_under
