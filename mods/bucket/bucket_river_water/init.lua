-- Load support for Minebase translation.
local S = minetest.get_translator("bucket_river_water")

-- River water source is 'liquid_renewable = false' to avoid horizontal spread
-- of water sources in sloping rivers that can cause water to overflow
-- riverbanks and cause floods.
-- River water source is instead made renewable by the 'force renew' option
-- used here.

bucket.register_liquid(
	"base_liquids:river_water_source",
	"base_liquids:river_water_flowing",
	"bucket_river_water:bucket",
	"bucket_river_water_bucket.png",
	S("River Water Bucket"),
	{tool = 1, water_bucket = 1},
	true
)

