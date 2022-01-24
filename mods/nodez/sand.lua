local S = ...

minetest.register_node("nodez:sand", {
	description = S("Sand"),
	tiles ={"nodez_sand.png"},
	groups = {crumbly=3},
	sounds = sound.sand ()
})
