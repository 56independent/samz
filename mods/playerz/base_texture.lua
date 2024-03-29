playerz.hair_colors = {
	black = {
		color = "#000000",
		ratio = 175,
	},
	gray = {},
	light_brown = {
		color = "#7a4c20",
		ratio = 150,
	},
	brown = {
		color = "#7a4c20",
		ratio = 192,
	},
	red = {
		color = "#ed6800",
		ratio = 140,
	},
	blonde = {
		color = "#a7ad06",
		ratio = 112,
	},
}

local hair_colors_redux = {}
for key, value in pairs(playerz.hair_colors) do
	hair_colors_redux[#hair_colors_redux+1] = key
end

playerz.skin_colors = {
	normal = nil,
	light_brown = {
		color = "#bea080",
		ratio = 225,
	},
	brown = {
		color = "#a56d40",
		ratio = 150,
	},
	black = {
		color = "#462409",
		ratio = 127,
	},
}

local skin_colors_redux = {}
for key, value in pairs(playerz.skin_colors) do
	skin_colors_redux[#skin_colors_redux+1] = key
end

playerz.eye_colors = {"brown", "gray", "green", "blue", "hazel", "violet", "black", "pink"}

function playerz.get_base_texture_table(player)
	local meta = player:get_meta()
	local base_texture_str = meta:get_string("base_texture")
	if base_texture_str == nil or base_texture_str == "" then
		playerz.set_base_textures(player)
	end
	local base_texture = minetest.deserialize(base_texture_str)
	return base_texture
end

function playerz.set_base_texture(player, base_texture)
	local meta = player:get_meta()
	meta:set_string("base_texture", minetest.serialize(base_texture))
end

function playerz.set_base_texture_by_gender(player, base_texture)
	local gender = playerz.get_gender(player)
	if gender == "male" then
		base_texture["eyebrowns"] = {texture = nil, color = nil}
		base_texture["mouth"] = {texture = "player_male_mouth_default.png", color = nil}
		base_texture["hair"] = {texture = "player_male_hair_default.png", color = base_texture["hair_color"]}
	else
		base_texture["eyebrowns"] = {texture = "player_eyebrowns_default.png", color = nil}
		base_texture["mouth"] = {texture = "player_female_mouth_default.png", color = nil}
		base_texture["hair"] = {texture = "player_female_hair_default.png", color = base_texture["hair_color"]}
	end
	return base_texture
end

function playerz.create_base_texture(player)
	local base_texture = {}
	base_texture["eye"] = "player_"..playerz.eye_colors[math.random(#playerz.eye_colors)].."_eye.png"
	base_texture["hair_color"] = hair_colors_redux[math.random(#hair_colors_redux)]
	base_texture = playerz.set_base_texture_by_gender(player, base_texture)
	local skin_color
	local model = playerz.registered_models[playerz.get_model_name(player)]
	--minetest.chat_send_all(playerz.get_model_name(player))
	if model.colorize_skin then
		skin_color = skin_colors_redux[math.random(#skin_colors_redux)]
	else
		skin_color = nil
	end
	base_texture["skin"] = {texture = model.textures[1], color = skin_color}
	return base_texture
end

function playerz.set_base_textures(player)
	playerz.set_base_texture(player, playerz.create_base_texture(player))
end

local function colorize_texture(base_texture, what, texture)
	if base_texture[what]["color"] then
		local value
		if what == "skin" then
			value = playerz.skin_colors[base_texture[what]["color"]]
		else --"hair"
			value = playerz.hair_colors[base_texture[what]["color"]]
		end
		if value and value.color then
			return texture .. "\\^\\[colorize\\:\\"..value.color.."\\:"..tostring(value.ratio)
		else
			return texture
		end
	else
		return texture
	end
end

function playerz.compose_base_texture(base_texture, def)

	local texture = "[combine:"..def.canvas_size..":0,0="..def.skin_texture

	if def.colorize_skin then
		texture = colorize_texture(base_texture, "skin", texture)
	end

	local ordered_keys = {}

	for key in pairs(base_texture) do
		table.insert(ordered_keys, key)
	end

	table.sort(ordered_keys)

	for i = 1, #ordered_keys do
		local key, value = ordered_keys[i], base_texture[ordered_keys[i]]
		if key == "eyebrowns" and value.texture then
			value.texture = colorize_texture(base_texture, "eyebrowns", value.texture)
			texture = texture .. ":"..def.eyebrowns_pos.."="..value.texture
		elseif key == "eye" then
			texture = texture .. ":"..def.eye_right_pos.."="..value
			texture = texture .. ":"..def.eye_left_pos.."="..value
		elseif key == "mouth" then
			texture = texture .. ":"..def.mouth_pos.."="..value.texture
		elseif key == "hair" then
			if def.hair_preview then
				value.texture = string.sub(value.texture, 0, -5).."_preview.png"
			end
			value.texture = colorize_texture(base_texture, "hair", value.texture)
			texture = texture .. ":"..def.hair_pos.."="..value.texture
		end
	end
	if def.scale then
		local dimensions = string.split(def.canvas_size, "x")
		texture = texture.."^[resize:"..tostring(tonumber(dimensions[1])*def.scale).."x"
			..tostring(tonumber(dimensions[2])*def.scale)
	end
	return texture
end
