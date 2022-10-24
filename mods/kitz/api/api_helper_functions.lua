function kitz.item_in_itemlist(item_name, itemlist)
	local match = false
	local table = false
	if type(itemlist) == "table" then
		table = true
	end
	if item_name and itemlist then
		local items
		if not table then
			items = string.split(itemlist, ',')
		else
			items = itemlist
		end
		for i = 1, #items do --loop  thru all items
			--minetest.chat_send_player("singleplayer", "itemlist item="..items[i])
			--minetest.chat_send_player("singleplayer", "item name="..item_name)
			local item = petz.str_remove_spaces(items[i]) --remove spaces
			if string.sub(item, 1, 5) == "group" then
				local item_group = minetest.get_item_group(item_name, string.sub(item, 7))
				if item_group > 0 then
					match = true
					break
				end
			else
				if item == item_name then --if node name matches
					match = true
					break
				end
			end
		end
		return match
	end
end

function kitz.remove_mob(self)
	--IMPORTANT: Firstly: Delete Behaviours
	kitz.clear_queue_high(self)
	kitz.clear_queue_low(self)
	self.object:remove()
end

function kitz.remove_table_by_key(tab, key)
	local i = 0
	local keys, values = {},{}
	for k, v in pairs(tab) do
		i = i + 1
		keys[i] = k
		values[i] = v
	end

	while i > 0 do
		if keys[i] == key then
			table.remove(keys, i)
			table.remove(values, i)
			break
		end
		i = i - 1
	end

	local new_tab = {}

	for j = 1, #keys do
		new_tab[keys[j]] = values[j]
	end

	return new_tab
end
