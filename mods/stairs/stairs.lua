local S = ...

stairs.register_stair_and_slab("stone", {
	recipeitem = "nodez:stone",
	groups = {cracky=3},
	images = {"nodez_stone.png"},
	desc_stair = S("Stone Stair"),
	desc_slab = S("Stone Slab")
})

stairs.register_stair_and_slab("cobble", {
	recipeitem = "nodez:cobble",
	groups = {cracky=3},
	images = {"nodez_cobble.png"},
	desc_stair = S("Cobblestone Stair"),
	desc_slab = S("Cobblestone Slab")
})

stairs.register_stair_and_slab("sandstone", {
	recipeitem = "nodez:sandstone",
	groups = {crumbly=3},
	images = {"nodez_sandstone.png"},
	desc_stair = S("Sandstone Stair"),
	desc_slab = S("Sandstone Slab")
})

--Treez-->

stairs.register_stair_and_slab("apple_tree", {
	recipeitem = "treez:apple_tree_wood",
	groups = {choppy = 2},
	images = {"treez_apple_tree_wood.png"},
	desc_stair = S("Apple Wood Stair"),
	desc_slab = S("Apple Wood Slab")
})

stairs.register_stair_and_slab("cherry_tree", {
	recipeitem = "treez:cherry_tree_wood",
	groups = {choppy = 2},
	images = {"treez_cherry_tree_wood.png"},
	desc_stair = S("Cherry Wood Stair"),
	desc_slab = S("Cherry Wood Slab")
})

stairs.register_stair_and_slab("chestnut_tree", {
	recipeitem = "treez:chestnut_tree_wood",
	groups = {choppy = 2},
	images = {"treez_chestnut_tree_wood.png"},
	desc_stair = S("Chestnut Wood Stair"),
	desc_slab = S("Chestnut Wood Slab")
})
