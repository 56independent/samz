S, modname = ...

local function compose_inv_img(color)
	local inv_img = "[combine:16x16:0,0=itemz_empty_flask.png:0,0=dyez_flask_content.png"
		.."\\^\\[colorize\\:\\"..color
	return inv_img
end

function dyez.register_dye(color)
	local _name = modname..":"..color
	local groups = {dye = 1, fabric = 1}
	groups["color_"..color] = 1

	minetest.register_craftitem(_name, {
		inventory_image = compose_inv_img(color),
		description = S("@1 Dye", S(helper.string.uppercase(color))),
		groups = groups
	})

	minetest.register_craft({
		type = "shapeless",
		output = _name,
		recipe = {
			"itemz:empty_flask",
			"group:color_"..color
		},
	})
end
