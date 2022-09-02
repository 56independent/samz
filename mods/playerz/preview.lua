function playerz.compose_preview(clicker, gender)
	local inv = clicker:get_inventory()
	local inv_list = inv:get_list("cloths")
	local head, upper, lower, underwear, footwear, hat
	for i = 1, #inv_list do
		local item_name = inv_list[i]:get_name()
		local cloth_type = minetest.get_item_group(item_name, "cloth")
		local texture = minetest.registered_items[item_name]._cloth_preview
		if cloth_type == 1 then
			head = texture
		elseif cloth_type == 2 then
			upper = texture
			underwear = true
		elseif cloth_type == 3 then
			lower = texture
		elseif cloth_type == 4 then
			footwear = texture
		elseif cloth_type == 5 then
			hat = texture
		end
	end
	if not(underwear) then
		upper = "cloth_upper_underwear_preview.png"
	end
	local _base_texture = playerz.get_base_texture_table(clicker)
	local base_texture = playerz.compose_base_texture(_base_texture, {
		canvas_size ="10x18",
		skin_texture = "player_preview.png",
		eyebrowns_pos = "2,2",
		eye_right_pos = "3,5",
		eye_left_pos = "6,5",
		mouth_pos = "2,7",
		hair_preview = true,
		hair_pos = "2,2",
	})
	local preview = base_texture
	if head then
		preview= preview .. ":2,2="..head
	end
	if upper then
		preview= preview .. ":0,8="..upper
	end
	if lower then
		preview= preview .. ":2,14="..lower
	end
	if footwear then
		preview= preview .. ":2,14="..footwear
	end
	if hat then
		preview= preview .. ":0,0="..hat
	end
	return preview
end

	--if minetest.get_modpath("3d_armor")~=nil then
		--local clicker_name = clicker:get_player_name()
		--texture = armor.textures[clicker_name].skin
		--5.4--texture = minetest.formspec_escape(armor.textures[clicker_name].skin)..","..
		--5.4armor.textures[clicker_name].armor..","..armor.textures[clicker_name].wielditem
	--else

		--5.4--texture = clicker:get_properties().textures[1]
	--end
	--minetest.chat_send_all(raw_texture)
