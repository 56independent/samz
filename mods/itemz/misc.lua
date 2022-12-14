S, modname = ...

--String

minetest.register_craftitem(modname..":".."string", {
    description = S("String"),
    inventory_image = "item_string.png",
    groups = {string = 1, tool = 1}
})

minetest.register_craft({
	output = modname..":".."string 4",
	type = "shapeless",
	recipe = {
		"floraz:reed"
	}
})
