Craft API 
---------

This mod provides registry functions for recurring combinations of craft
recipes.  

```txt
craft.register_craft14(one, four)
one     : Itemname
four    : Itemname
```
| input	|	| output 	||
|:-----:|:-----:|:-------------:|:-----:|
| one	| &harr;| four 		| four	|
|	|	| four 	 	| four  |				

```txt
craft.register_craft44(four1, four2)
four1   : Itemname
four2   : Itemname
```
| input	|	|	| output 	||
|:-----:|:-----:|:-----:|:-------------:|:-----:|
| four1	| four1	| &harr;| four2 	| four2	|
| four1	| four1	| 	| four2	 	| four2 |				

```txt
craft.register_craft19(one, nine)
one     : Itemname
nine    : Itemname
```
| input	|	| output|||
|:-----:|:-----:|:-----:|:-----:|:-----:|
| one	| &harr;| nine 	| nine	| nine	|
| 	| 	| nine	| nine	| nine	|
| 	|	| nine	| nine	| nine	|

```txt
craft.register_craft99(nine1, nine2)`
nine1   : Itemname
nine2   : Itemname
```
| input	|	|	|	| output|||
|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|
| nine1	| nine1	| nine1	| &harr;| nine2	| nine2	| nine2	|
| nine1	| nine1	| nine1	|	| nine2	| nine2	| nine2	|
| nine1	| nine1	| nine1	|	| nine2	| nine2	| nine2	|

```txt
craft.horizontal_half(part, result)
part    : Itemname
result  : Itemname
```
| input	|	|	|	| output|
|:-----:|:-----:|:-----:|:-----:|:-----:|
| nine1	| nine1	| nine1	| &rarr;| result

```txt
craft.side_by_side(one, two, result)
one     : Itemname
two     : Itemname
result  : Itemname (optional)

If result is omitted, one is used twice and two becomes the result.
```
| input	|	|	| output|
|:-----:|:-----:|:-----:|:-----:|
| one	| two	| &rarr;| result


```txt
craft.stacked(one, two, result)
one     : Itemname
two     : Itemname
result  : Itemname (optional)

If result is omitted, one is used twice and two becomes the result.
```
| input	|	| output|
|:-----:|:-----:|:-----:|
| one	| &rarr;| result
| two	|	| 

