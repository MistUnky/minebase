Minebase mod: Base Protection
=============================
See license.txt for license information.

This mod registeres keys, which allow players to interact with spezific nodes 
owned by other players. A key needs to be bound to a specific node by punching 
that node with the key.

base.can_interact_with_node returns true in three cases:
- he is the owner
- he is using a correct key
- he has the privilege to bypass protection
Otherwise this function returns false.

Authors of source code
----------------------
Originally by celeron55, Perttu Ahola <celeron55@gmail.com> (LGPLv2.1+)
Various Minetest developers and contributors (LGPLv2.1+)

Authors of media (textures, sounds, models and schematics)
----------------------------------------------------------
Everything not listed in here:
celeron55, Perttu Ahola <celeron55@gmail.com> (CC BY-SA 3.0)


Textures
--------
Gambit (CC BY-SA 3.0):
  base_protection_key.png
  base_protection_key_skeleton.png

