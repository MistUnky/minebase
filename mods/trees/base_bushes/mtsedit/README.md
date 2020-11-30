# Minetest mod: mtsedit

## Description
This will add chat commands (“mtsedit”) to export data to MTSEdit and import
MTS files into the world. The first reads in (world folder)/blocks.csv, adds a
coloumn to it then saves it back. If the file do not exists, it will be created.
The import reads in MTS files from the(world folder)/schems/ directory, which
you can place easily with a placement tool.

The other part of MTSEdit runs outside of the game, and is written in ANSI C.
Its source as well as the detailed documentation of this mod can be found
[here](https://gitlab.com/bztsrc/mtsedit)

Version: 1.0.0

## Authors
- bzt (MIT License)

See license.txt for license information.
