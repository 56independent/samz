local S = ...

minetest.register_node("nodez:dirt", {
	description = S("Dirt"),
	tiles ={"default_dirt.png"},
	groups = {crumbly=3, soil=1},
})

minetest.register_node("nodez:dirt_with_grass", {
	description = S("Dirt with Grass"),
	tiles ={"default_grass.png",
		-- a little dot on the bottom to distinguish it from dirt
		"default_dirt.png^basenodes_dirt_with_grass_bottom.png",
		{name = "default_dirt.png^default_grass_side.png",
		tileable_vertical = false}},
	groups = {crumbly=3, soil=1},
})
