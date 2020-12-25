-- Load support for Minebase translation.
local S = minetest.get_translator("bucket_lava")

minetest.register_alias("bucket_lava", "bucket_lava:bucket")

bucket.register_liquid(
	"base_liquids:lava_source",
	"base_liquids:lava_flowing",
	"bucket_lava:bucket",
	"bucket_lava_bucket.png",
	S("Lava Bucket"),
	{tool = 1}
)

minetest.register_craft({
	type = "fuel",
	recipe = "bucket_lava:bucket",
	burntime = 60,
	replacements = {{"bucket_lava:bucket", "bucket_api:bucket_empty"}},
})

-- Register buckets as dungeon loot
if minetest.global_exists("dungeon_loot") then
	dungeon_loot.register({
		-- lava below ground
		{name = "bucket_lava:bucket", chance = 0.45, y = {-32768, -1},
			types = {"normal"}},
	})
end
