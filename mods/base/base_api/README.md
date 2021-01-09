Minebase mod: Base API
======================
See license.txt for license information.  
  
This mod provides registry functions for recurring combinations of craft
recipes. They all receive two name strings.  

base.register_craft14(one, four)  

| input	|	| output 	||
|:-----:|:-----:|:-------------:|:-----:|
| one	| &harr;| four 		| four	|
|	|	| four 	 	| four  |				

base.register_craft44(four1, four2)

| input	|	|	| output 	||
|:-----:|:-----:|:-----:|:-------------:|:-----:|
| four1	| four1	| &harr;| four2 	| four2	|
| four1	| four1	| 	| four2	 	| four2 |				

base.register_craft19(one, nine)

| input	|	| output|||
|:-----:|:-----:|:-----:|:-----:|:-----:|
| one	| &harr;| nine 	| nine	| nine	|
| 	| 	| nine	| nine	| nine	|
| 	|	| nine	| nine	| nine	|

base.register_craft99(nine1, nine2)

| input	|	|	|	| output|||
|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|
| nine1	| nine1	| nine1	| &harr;| nine2	| nine2	| nine2	|
| nine1	| nine1	| nine1	|	| nine2	| nine2	| nine2	|
| nine1	| nine1	| nine1	|	| nine2	| nine2	| nine2	|

base.get_inventory_drops(pos, list, drops)  
&nbsp;&nbsp;&nbsp;&nbsp;
	It copies the items of the inventory list in the inventory at pos as
	tables into the output table drops.

Authors of source code
----------------------
LibraSubtilis (LGPLv3+)


