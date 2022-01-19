local S = ...

minetest.register_node("nodez:sand", {
	description = S("Sand"),
	tiles ={"default_sand.png"},
	groups = {crumbly=3},
})

minetest.register_node("nodez:desert_sand", {
	description = S("Desert Sand"),
	tiles ={"default_desert_sand.png"},
	groups = {crumbly=3},
})
