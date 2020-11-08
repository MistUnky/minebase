-- carts_api/init.lua

carts = {}
carts.modpath = minetest.get_modpath("carts_api")
carts.railparams = {}

-- Maximal speed of the cart in m/s (min = -1)
carts.speed_max = 7
-- Set to -1 to disable punching the cart from inside (min = -1)
carts.punch_speed_max = 5
-- Maximal distance for the path correction (for dtime peaks)
carts.path_distance_max = 3

dofile(carts.modpath.."/functions.lua")
