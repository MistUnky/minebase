-- Load support for Minebase translation.
local S = minetest.get_translator("bucket_water")

minetest.register_alias("bucket_water", "bucket_water:bucket")

bucket.register_liquid(
	"default:water_source",
	"default:water_flowing",
	"bucket_water:bucket",
	"bucket_water_bucket.png",
	S("Water Bucket"),
	{tool = 1, water_bucket = 1}
)

-- Register buckets as dungeon loot
if minetest.global_exists("dungeon_loot") then
	dungeon_loot.register({
		-- water in deserts/ice or above ground
		{name = "bucket_water:bucket", chance = 0.45,
			types = {"sandstone", "desert", "ice"}},
		{name = "bucket_water:bucket", chance = 0.45, y = {0, 32768},
			types = {"normal"}},
	})
end
