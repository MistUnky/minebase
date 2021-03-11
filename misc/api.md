Keywords 
--------

OR  
Is used to connect alternatives.

...  
Is used to express possible repetition or continuation of a pattern.

[ ]  
The enclosed Element or character sequence is optional.

?
Used to express an unknown value.

### Types 

BiomeDef
A table with keys used in a biome definition.

Boolean  
A type with the two possible values true and false.

Box   
A table with two coordinates. The keys are 1, 2, 3, 4, 5 and 6 not x1, y1 etc..  
{x1, y1, z1, x2, y2, z2}

Byte  
An Integer in the range of 0 to 255.

Formspec
A string containing formspec definitions.

Integer  
An number value without a fractional component.

InvRef  
A reference to an inventory of the Minetest Engine.

ItemStack
An object representing a stack of items. It occupies one slot in an inventory.

Listname  
A string associated with a list of ItemStacks in an inventory.

Name  
A string representing a registered item, node, entity, biome or something else. 
"mod:item", "mod:node", "mod:biome"

Node  
A table with values assigned to the keys name, param1 and param2.  
{name = Name, param1 = Byte, param2 = Byte}

Player  
An ObjectRef representing a Player. The object only lasts as long as the player
is logged in. In case he logs in again a different object is created.

PointedThing  
A table representing the pointed node, object or nothing.  
{type = "nothing"}, {type = "node", under = Position, above = Position}, {type = "object", ref = ObjectRef}

Position  
A table with numeric values assigned to the keys x, y and z. Keep in mind that the y axis is pointing upwards.  
{x = 0, y = 0, z = 0} 

String
A type representing character sequences with ASCII or UTF-8 characters. They are
enclosed with " or ' within the code.
"abcde", 'éßâ'

Table  
A lua table.

Texture  
A string containing the name of a texture.  
"mod_item.png"
