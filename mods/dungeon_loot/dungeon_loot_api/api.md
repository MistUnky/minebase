Dungeon Loot 
------
#### filter_rooms
```lua
```
#### find_walls
```lua
```
#### get_loot
Returns the loot available in a specified position and dungeontype.
```lua
function dungeon_loot.get_loot(pos, dungeontype)
pos             : Position
dungeontype     : DungeonTypeList
return          : LootDefList, LootDefParts
```
DungeonTypeList is a table of dungeon types the loot is going to be found in. 
"normal", "desert", "sandstone" and "ice" are currently supported.  
LootDefList is a list of LootDefs.  
LootDefParts is a corresponding list of their part values.

#### populate_chest
```lua
```
#### register_loot
Registers a single item or a sequence of items as dungeon loot.
```lua
function dungeon_loot.register_loot(loot)
loot    : Mixed ⊆ {LootDef, {LootDef}}

LootDef {
	name = Name, part = Integer, count = {Integer, Integer}, 
	x = {Integer, Integer}, y = {Integer, Integer}, 
	z = {Integer, Integer},
	types = DungeonTypeList
}
```
part is the amount of times the item is put into a chest in ratio to the sum of 
all part values for items that can be placed inside a chest on a given position.  
count represents the minimum and maximum amount of items found inside a chest.  
x, y and z are optional tables with min and max values for chests the items are 
going to be found in.  
