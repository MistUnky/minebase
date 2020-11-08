-- carts/init.lua

-- Aliases for Mintest Game carts mod
minetest.register_alias("carts:rail", "base_rails:rail")
minetest.register_alias("carts:powerrail", "base_rails:powerrail")
minetest.register_alias("carts:brakerail", "base_rails:brakerail")
minetest.register_alias("carts:cart", "base_cart:cart")

minetest.register_entity("carts:cart", {
	on_activate = function (self, staticdata)
		minetest.add_entity(self.object:get_pos(), "base_cart:cart", staticdata)
		self.object:remove()
	end
})
