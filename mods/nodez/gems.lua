local S = ...

minetest.register_node("nodez:ruby_ore", {
	description = S("Ruby Ore"),
	tiles = {"nodez_stone.png^nodez_ruby_ore.png"},
	groups = {cracky=1, ore=1},
	drop = "nodez:ruby",
	sounds = sound:stone(),
})

minetest.register_craftitem("nodez:ruby", {
	description = S("Ruby"),
	groups = {gem=1, ore=1},
	inventory_image = "nodez_ruby.png",
})
