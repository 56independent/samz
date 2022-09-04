local S = minetest.get_translator("playerz")

function playerz.has_cloths(player)
	local inv = player:get_inventory()
	if inv:is_empty("cloths") then
		return false
	else
		return true
	end
end

function playerz.register_cloth(name, def)
	if not(def.inventory_image) then
		def.wield_image = def.texture
	end
	if not(def.wield_image) then
		def.wield_image = def.inventory_image
	end
	local tooltip
	local gender, gender_color
	local description
	if not def.attached then
		if def.groups["cloth"] == 1 then
			tooltip = S("Head")
		elseif def.groups["cloth"] == 2 then
			tooltip = S("Upper")
		elseif def.groups["cloth"] == 3 then
			tooltip = S("Lower")
		elseif def.groups["cloth"] == 4 then
			tooltip = S("Footwear")
		elseif def.groups["cloth"] == 5 then
			tooltip = S("Hat")
		end
		tooltip = "(" .. tooltip .. ")"
		if def.gender == "male" then
			gender = S("Male")
			gender_color = "#00baff"
		elseif def.gender == "female" then
			gender = S("Female")
			gender_color = "#ff69b4"
		else
			gender = S("Unisex")
			gender_color = "#9400d3"
		end
		tooltip = tooltip.."\n".. minetest.colorize(gender_color, gender)
		description = def.description .. "\n" .. tooltip
	end
	minetest.register_craftitem(name, {
		description = description or nil,
		inventory_image = def.inventory_image or nil,
		wield_image = def.wield_image or nil,
		stack_max = def.stack_max or 16,
		_cloth_attach = def.attach or nil,
		_cloth_attached = def.attached or false,
		_cloth_texture = def.texture or nil,
		_cloth_preview = def.preview or nil,
		_cloth_gender = def.gender or nil,
		groups = def.groups or nil,
	})
end

playerz.register_cloth("playerz:cloth_female_upper_default", {
	description = S("Purple Stripe Summer T-shirt"),
	inventory_image = "cloth_female_upper_default_inv.png",
	wield_image = "cloth_female_upper_default.png",
	texture = "cloth_female_upper_default.png",
	preview = "cloth_female_upper_preview.png",
	gender = "female",
	groups = {cloth = 2},
})

playerz.register_cloth("playerz:cloth_female_lower_default", {
	description = S("Fresh Summer Denim Shorts"),
	inventory_image = "cloth_female_lower_default_inv.png",
	wield_image = "cloth_female_lower_default_inv.png",
	texture = "cloth_female_lower_default.png",
	preview = "cloth_female_lower_preview.png",
	gender = "female",
	groups = {cloth = 3},
})

playerz.register_cloth("playerz:cloth_unisex_footwear_default", {
	description = S("Common Black Shoes"),
	inventory_image = "cloth_unisex_footwear_default_inv.png",
	wield_image = "cloth_unisex_footwear_default_inv.png",
	texture = "cloth_unisex_footwear_default.png",
	preview = "cloth_unisex_footwear_preview.png",
	gender = "unisex",
	groups = {cloth = 4},
})

playerz.register_cloth("playerz:cloth_female_head_default", {
	description = S("Pink Bow"),
	inventory_image = "cloth_female_head_default_inv.png",
	wield_image = "cloth_female_head_default_inv.png",
	texture = "cloth_female_head_default.png",
	preview = "cloth_female_head_preview.png",
	gender = "female",
	groups = {cloth = 1},
})

playerz.register_cloth("playerz:cloth_male_upper_default", {
	description = S("Classic Green Sweater"),
	inventory_image = "cloth_male_upper_default_inv.png",
	wield_image = "cloth_male_upper_default_inv.png",
	texture = "cloth_male_upper_default.png",
	preview = "cloth_male_upper_preview.png",
	gender = "male",
	groups = {cloth = 2},
})

playerz.register_cloth("playerz:cloth_male_lower_default", {
	description = S("Fine Brown Pants"),
	inventory_image = "cloth_male_lower_default_inv.png",
	wield_image = "cloth_male_lower_default_inv.png",
	texture = "cloth_male_lower_default.png",
	preview = "cloth_male_lower_preview.png",
	gender = "male",
	groups = {cloth = 3},
})

function playerz.set_cloths(player)
	local gender = player:get_meta():get_string("gender")
	--Create the "cloths" inventory
	local inv = player:get_inventory()
	inv:set_size("cloths", 8)

	if gender == "male" then
		inv:add_item("cloths", 'playerz:cloth_male_upper_default')
		inv:add_item("cloths", 'playerz:cloth_male_lower_default')
	else
		inv:add_item("cloths", 'playerz:cloth_female_head_default')
		inv:add_item("cloths", 'playerz:cloth_female_upper_default')
		inv:add_item("cloths", 'playerz:cloth_female_lower_default')
	end
	inv:add_item("cloths", 'playerz:cloth_unisex_footwear_default')
end

playerz.cloth_pos = {
	"18,0",
	"12,12",
	"0,12",
	"0,12",
}

function playerz.compose_cloth(player)
	local inv = player:get_inventory()
	local inv_list = inv:get_list("cloths")
	local upper_ItemStack, lower_ItemStack, footwear_ItemStack, head_ItemStack, hat_ItemStack
	local underwear = false
	local attached_cloth = {}
	for i = 1, #inv_list do
		local item_name = inv_list[i]:get_name()
		local cloth_itemstack = minetest.registered_items[item_name]
		--minetest.chat_send_all(item_name)
		local cloth_type = minetest.get_item_group(item_name, "cloth")
		--if cloth_type then minetest.chat_send_all(cloth_type) end
		if cloth_type == 1 then
			head_ItemStack = cloth_itemstack._cloth_texture
		elseif cloth_type == 2 then
			upper_ItemStack = cloth_itemstack._cloth_texture
			underwear = true
		elseif cloth_type == 3 then
			lower_ItemStack = cloth_itemstack._cloth_texture
		elseif cloth_type == 4 then
			footwear_ItemStack = cloth_itemstack._cloth_texture
		elseif cloth_type == 5 then
			hat_ItemStack = cloth_itemstack._cloth_texture
		end
		if cloth_itemstack._cloth_attach then
			attached_cloth[#attached_cloth+1] = cloth_itemstack._cloth_attach
		end
	end
	if not(underwear) then
		upper_ItemStack = "cloth_upper_underwear_default.png"
	end
	local _base_texture = playerz.get_base_texture_table(player)
	local base_texture = playerz.compose_base_texture(_base_texture, {
		canvas_size ="48x20",
		skin_texture = "player_skin.png",
		eyebrowns_pos = "6,6",
		eye_right_pos = "7,9",
		eye_left_pos = "10,9",
		mouth_pos = "6,11",
		hair_preview = false,
		hair_pos = "0,0",
	})
	local cloth = base_texture.."^".."[combine:48x20:0,0="
	if head_ItemStack then
		cloth = cloth .. ":"..playerz.cloth_pos[1].."="..head_ItemStack
	end
	if upper_ItemStack then
		cloth = cloth .. ":"..playerz.cloth_pos[2].."="..upper_ItemStack
	end
	if lower_ItemStack then
		cloth = cloth .. ":"..playerz.cloth_pos[3].."="..lower_ItemStack
	end
	if footwear_ItemStack then
		cloth = cloth .. ":"..playerz.cloth_pos[4].."="..footwear_ItemStack
	end
	--Now attached cloth
	if not(next(attached_cloth) == nil) then
		for i = 1, #attached_cloth do
			local attached_item_name = attached_cloth[i]
			local attached_itemstack = minetest.registered_items[attached_item_name]
			local attached_cloth_type = minetest.get_item_group(attached_item_name, "cloth")
			cloth = cloth .. ":"..playerz.cloth_pos[attached_cloth_type].."="..attached_itemstack._cloth_texture
		end
	end
	return cloth, hat_ItemStack
end

--Appearance Form

local _contexts = {}

local function get_context(name, field)
    if not _contexts[name] then
		_contexts[name] = {}
	end
    return _contexts[name][field]
end

local function set_context(name, field, value)
	if not _contexts[name] then
		_contexts[name] = {}
	end
	 _contexts[name][field] = value
end

function playerz.set_closet_context(player_name, pos)
	set_context(player_name, "closet", true)
	set_context(player_name, "pos", pos)
end

function playerz.reset_closet_context(player_name)
	set_context(player_name, "closet", false)
	set_context(player_name, "pos", nil)
end

--Appearance Inventory Page

sfinv.register_page("sfinv:appearance", {
	title = S("Appearance"),
	get = function(self, player, context)
		return sfinv.make_formspec(player, context, [[
			image[0.5,0.5;2,3.5;]]..minetest.formspec_escape(playerz.compose_preview(player, playerz.get_gender(player)))..[[]
			list[current_player;cloths;2.5,0.125;2,4]
		]], true)
	end,
})

minetest.register_on_leaveplayer(function(player)
    _contexts[player:get_player_name()] = nil
end)

-- Allow only "cloth" groups to put/move

minetest.register_allow_player_inventory_action(function(player, action, inventory, inventory_info)
	local stack, from_inv, to_index
	if action == "move" and inventory_info.to_list == "cloths" then
		--for moving inside the 'cloths' inventory-->
		if inventory_info.from_list == inventory_info.to_list then
			return 1
		end
		--for moving items from player inventory list 'main' to 'cloths'-->
		from_inv = "main"
		to_index = inventory_info.to_index
		stack = inventory:get_stack(inventory_info.from_list, inventory_info.from_index)
	elseif action == "put" and inventory_info.listname == "cloths" then
		--for moving from node inventory 'closet' to player inventory 'cloths'
		from_inv = "closet"
		to_index = inventory_info.index
		stack = inventory_info.stack
	else
		return
	end
	if stack then
		local stack_name = stack:get_name()
		local item_group = minetest.get_item_group(stack_name , "cloth")
		if item_group == 0 then --not a cloth
			return 0
		end
		--search for another cloth of the same type
		local player_inv = player:get_inventory()
		local cloth_list = player_inv:get_list("cloths")
		for i = 1, #cloth_list do
			local cloth_name = cloth_list[i]:get_name()
			local cloth_type = minetest.get_item_group(cloth_name, "cloth")
			if cloth_type == item_group then
				if player_inv:get_stack("cloths", to_index):get_count() == 0 then --if put on an empty slot
					if from_inv == "main" then
						if player_inv:room_for_item("main", cloth_name) then
							player_inv:remove_item("cloths", cloth_name)
							player_inv:add_item("main", cloth_name)
							return 1
						end
					else --closet inventory
						local closetz_inv = minetest.get_inventory({ type="node", pos=get_context(player:get_player_name(), "pos")})
						if closetz_inv:room_for_item("closet", cloth_name) then
							player_inv:remove_item("cloths", cloth_name)
							closetz_inv:add_item("closet", cloth_name)
							return 1
						end
					end
				end
				return 0
			end
		end
		return 1
	end
	return 0
end)

minetest.register_on_player_inventory_action(function(player, action, inventory, inventory_info)
	local update_cloths
	if (action == "move" and inventory_info.to_list == "cloths") then
		--for moving items from player inventory list 'main' to 'cloths'
		if inventory_info.from_list == inventory_info.to_list then --for moving inside the 'cloths' inventory
			update_cloths = false
		else
			update_cloths = true
		end
	elseif (action == "move" and inventory_info.to_list == "main" and inventory_info.from_list == "cloths") then
		update_cloths = true
	elseif (action == "put" or action == "take") and inventory_info.listname == "cloths" then
		update_cloths = true
	else
		return
	end
	if update_cloths then
		playerz.set_texture(player)
		local player_name = player:get_player_name()
		if get_context(player_name, "closet") then
			minetest.show_formspec(player_name,
				"closetz:container", closetz.container.get_container_formspec(get_context(player_name, "pos"), player))
		else
			sfinv.set_page(player, "sfinv:appearance")
		end
	end
end)
