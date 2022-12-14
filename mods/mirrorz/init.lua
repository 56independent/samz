--
-- mirrorz
-- License:GPLv3
--

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

--
-- Mirrors Mod
--

minetest.register_node("mirrorz:mirror", {
	description = S("Mirror"),
	inventory_image = "mirrorz_mirror_inv.png",
	wield_image = "mirrorz_mirror_inv.png",
	tiles = {"mirrorz_mirror.png", "mirrorz_mirror.png", "mirrorz_mirror.png", "mirrorz_mirror.png",
		"mirrorz_mirror_back.png","mirrorz_mirror.png"},
	groups = {mirror = 1, cracky=1, oddly_breakable_by_hand=1, deco=1},
	sounds = sound.glass(),
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5 },
		},
	},
})

minetest.register_craft({
	output = "mirrorz:mirror",
	type = "shaped",
	recipe = {
		{"", "group:glass"},
		{"", "group:wood"}
	}
})
