local S, modname = ...

function ladderz.register_ladder(name, def)

	local ladder_name = modname..":"..name
	local tile = "ladderz_ladder_"..name..".png"
	local inventory_image = def.inventory_image or tile
	local _sound
	if def.sound == "iron" then
		_sound = sound.metal()
	else
		_sound = sound.wood()
	end

	minetest.register_node(ladder_name, {
		description = S("@1 Ladder", def.description),
		drawtype = "nodebox",
		paramtype = 'light',
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.4375, -0.3125, 0.5, -0.375, -0.0625},
				{-0.5, -0.4375, 0.1875, 0.5, -0.375, 0.4375},
				{-0.375, -0.5, -0.5, -0.1875, -0.4375, 0.5},
				{0.1875, -0.5, -0.5, 0.375, -0.4375, 0.5},
			},
		},
        selection_box = {
            type = 'fixed',
            fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5}
            },
        },
		tiles = {tile, def.material, def.material, def.material, def.material, def.material},
		inventory_image = inventory_image,
		wield_image = def.wield_image or def.inventory_image or def.tiles,
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = true,
		climbable = true,
		is_ground_content = false,
		groups = {choppy = 2, oddly_breakable_by_hand = 3, flammable = 2, ladder =1, deco = 1, build = 1},
		legacy_wallmounted = true,
		sounds = _sound,
	})

	minetest.register_craft({
		output = ladder_name .. " 4",
		type = "shaped",
		recipe = {
			{"", def.recipe},
			{"", def.recipe}
		}
	})
end

