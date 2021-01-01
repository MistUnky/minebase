-- containers/init.lua

-- Aliases to support loading worlds using nodes following the old naming convention
-- These can also be helpful when using chat commands, for example /giveme
minetest.register_alias("chest", "chests:common")
minetest.register_alias("locked_chest", "chests:common_locked")
minetest.register_alias("bookshelf", "shelves:book")


minetest.register_alias("default:chest", "chests:common")
minetest.register_alias("default:chest_locked", "chests:common_locked")
minetest.register_alias("default:bookshelf", "shelves:book")
minetest.register_alias("vessels:shelf", "shelves:vessels")

