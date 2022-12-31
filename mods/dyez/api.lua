S, modname = ...

local function compose_inv_img(color)
	local inv_img = "[combine:16x16:0,0=itemz_empty_flask.png:0,0=dyez_flask_content.png"
		.."\\^\\[colorize\\:\\"..color
	return inv_img
end

function dyez.is_dyeable(pos)
	local palette_count = helper.in_group(pos, "dyeable")
	if palette_count then
		local node = minetest.get_node_or_nil(pos)
		return node, palette_count
	else
		return false
	end
end

function dyez.register_dye(color, def)
	local _name = modname..":"..color
	local groups = {dye = 1, fabric = 1}
	groups["color_"..color] = 1

	local color_description, colorstring

	if not def[1] then
		color_description = helper.string.uppercase(color)
	else
		color_description = def[1]
	end

	if not def[2] then
		colorstring = color
	else
		colorstring = def[2]
	end

	minetest.register_craftitem(_name, {
		inventory_image = compose_inv_img(colorstring),
		description = S("@1 Dye", S(color_description)),
		groups = groups,

		on_use = function(itemstack, user, pointed_thing)
			if not pointed_thing.type == "node" then
				return
			end
			local pos = minetest.get_pointed_thing_position(pointed_thing)
			if not pos then
				return
			end
			local node, palette_count = dyez.is_dyeable(pos)
			if node then
				local palette_idx = def[3]
				if palette_idx > palette_count then
					local available_colors = ""
					for _color, _def in pairs(dyez.colors) do
						if _def[3] < palette_count then
							if not(available_colors == "") then
								available_colors = available_colors .. ", "
							end
							local _color_description
							if not _def[1] then
								_color_description = helper.string.uppercase(_color)
							else
								_color_description = _def[1]
							end
							available_colors = available_colors .. S(_color_description)
						end
					end
					minetest.chat_send_player(user:get_player_name(), S("You can only use the following colors")..": "
						..available_colors)
					return
				end
				local param2 = palette_idx
				if minetest.registered_nodes[node.name]["paramtype2"] == "colorfacedir" then
					local old_color = minetest.strip_param2_color(node.param2, "colorfacedir")
					rotation = node.param2 - (old_color or 0)
					param2 = (32*param2) + rotation
				end
				minetest.set_node(pos, {name = node.name, param2 = param2})
				if user:is_player() then
					if itemstack:get_count() == 1 then
						user:set_wielded_item("itemz:empty_flask")
					else
						itemstack:take_item()
						return itemstack
					end
				end
			end
		end,
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
