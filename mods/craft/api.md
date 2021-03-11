Craft API 
---------

This mod provides registry functions for recurring combinations of craft
recipes.  

#### register_craft14
| input	|	| output 	||
|:-----:|:-----:|:-------------:|:-----:|
| one	| &harr;| four 		| four	|
|	|	| four 	 	| four  |				
```lua
craft.register_craft14(one, four)
one     : Name
four    : Name
```

#### register_craft19
| input	|	| output|||
|:-----:|:-----:|:-----:|:-----:|:-----:|
| one	| &harr;| nine 	| nine	| nine	|
| 	| 	| nine	| nine	| nine	|
| 	|	| nine	| nine	| nine	|
```lua
craft.register_craft19(one, nine)
one     : Name
nine    : Name
```

#### register_craft44
| input	|	|	| output 	||
|:-----:|:-----:|:-----:|:-------------:|:-----:|
| four1	| four1	| &harr;| four2 	| four2	|
| four1	| four1	| 	| four2	 	| four2 |				
```lua
craft.register_craft44(four1, four2)
four1   : Name
four2   : Name
```

#### register_craft99
| input	|	|	|	| output|||
|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|
| nine1	| nine1	| nine1	| &harr;| nine2	| nine2	| nine2	|
| nine1	| nine1	| nine1	|	| nine2	| nine2	| nine2	|
| nine1	| nine1	| nine1	|	| nine2	| nine2	| nine2	|
```lua
craft.register_craft99(nine1, nine2)`
nine1   : Name
nine2   : Name
```

#### register_craft_metadata_copy
Registers a craft recipe that copies the metadata of one item to a new item of 
type result. The original item used for crafting is preserved. The craft recipe 
is shapeless.
```lua
function craft.register_craft_metadata_copy(ingredient, result)
ingredient      : Name
result          : Name
```

#### horizontal_half
| input	|	|	|	| output|
|:-----:|:-----:|:-----:|:-----:|:-----:|
| part	| part	| part	| &rarr;| result
```lua
craft.horizontal_half(part, result)
part    : Name
result  : Name
```

#### side_by_side
| input	|	|	| output|
|:-----:|:-----:|:-----:|:-----:|
| one	| two	| &rarr;| result

```lua
craft.side_by_side(one, two[, result])
one     : Name
two     : Name
result  : Name
```
If result is omitted, one is used twice and two becomes the result.

#### stacked
| input	|	| output|
|:-----:|:-----:|:-----:|
| two	| &rarr;| result
| one	|	| 

```lua
craft.stacked(one, two[, result])
one     : Name
two     : Name
result  : Name
```
If result is omitted, one is used twice and two becomes the result.

