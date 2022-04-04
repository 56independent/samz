local S, modname = ...

function nodez.register_roof(name, def)
	minetest.register_node(modname..":"..name.."_slope", {
		description = def.description.." ".."Slope",
		drawtype= "mesh",
		mesh = "nodez_roof_slope.b3d",
		tiles = def.tiles,
		use_texture_alpha = true,
		is_ground_content = false,
		paramtype2 = "facedir",
		groups = {cracky = 3, stone = 1},
		sounds = sound.stone(),
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			}
		}
	})

	minetest.register_node(modname..":"..name.."_corner", {
		description = def.description.." ".."Corner",
		drawtype= "mesh",
		mesh = "nodez_roof_corner.b3d",
		tiles = def.tiles,
		use_texture_alpha = true,
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = {cracky = 3, stone = 1},
		sounds = sound.stone(),
	})

	minetest.register_node(modname..":"..name.."_flat", {
		description = def.description.." ".."Flat",
		tiles = def.flat_tiles,
		is_ground_content = false,
		paramtype2 = "facedir",
		groups = {cracky = 3, stone = 1},
		sounds = sound.stone(),
	})

end

nodez.register_roof("red_roof", {
	description = "Red Roof",
	tiles = {"nodez_roman_roof.png"},
	flat_tiles = {"nodez_red_gables.png", "nodez_adobe.png"}
})
