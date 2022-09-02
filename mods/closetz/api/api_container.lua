closetz.container = {}
closetz.container.open_containers = {}

local function get_bg(x,y,rows,columns,image)
	local out = ""
	for i=0,columns do
		out = out .."image["..x+i..","..y..";1,1;"..image.."]"
		for j = 0,rows do
			out = out .."image["..x+i..","..y+j..";1,1;"..image.."]"
		end
	end
	return out
end

function closetz.container.get_container_formspec(pos, clicker)
	local gender = playerz.get_gender(clicker)
	--5.4--local model = playerz.get_gender_model(gender)
	local preview = playerz.compose_preview(clicker, gender)
	local spos = pos.x .. "," .. pos.y .. "," .. pos.z
	local formspec =
		"size[8,8.25]" ..
		--5.4--"model[0,0;5,5;preview_model;"..model..";"..texture..";-10,195;;;0,79]"..
		"image[0.5,0.5;2,4;"..minetest.formspec_escape(preview).."]" ..
		"list[current_player;cloths;2.5,0.25;2,4]" ..
		get_bg(2.5,0.25,3,1,"closetz_gui_clothes_bg.png")..
		"list[nodemeta:" .. spos .. ";closet;5,0.25;3,12;]" ..
		get_bg(5,0.25,3,2,"closetz_gui_closet_bg.png")..
		"list[current_player;main;0,4.5;8,1;]" ..
		"list[current_player;main;0,5.5;8,3;8]"
		--get_bg(0,4.5,3,2,"closetz_gui_closetz_bg.png")
		--default.get_hotbar_bg(0,4.5)
	return formspec
end

function closetz.container.container_lid_close(pn)
	local container_open_info = closetz.container.open_containers[pn]
	local pos = container_open_info.pos
	local sound = container_open_info.sound
	local swap = container_open_info.swap

	closetz.container.open_containers[pn] = nil
	for k, v in pairs(closetz.container.open_containers) do
		if v.pos.x == pos.x and v.pos.y == pos.y and v.pos.z == pos.z then
			return true
		end
	end

	local node = minetest.get_node(pos)
	minetest.after(0.2, minetest.swap_node, pos, { name = "closetz:" .. swap,
			param2 = node.param2 })
	minetest.sound_play(sound, {gain = 0.3, pos = pos, max_hear_distance = 10})
end

minetest.register_on_leaveplayer(function(player)
	local pn = player:get_player_name()
	if closetz.container.open_containers[pn] then
		closetz.container.container_lid_close(pn)
	end
end)

function closetz.container.container_lid_obstructed(pos, direction)
	if direction == "above" then
		pos = {x = pos.x, y = pos.y + 1, z = pos.z}
	end
	local def = minetest.registered_nodes[minetest.get_node(pos).name]
	-- allow ladders, signs, wallmounted things and torches to not obstruct
	if def and
			(def.drawtype == "airlike" or
			def.drawtype == "signlike" or
			def.drawtype == "torchlike" or
			(def.drawtype == "nodebox" and def.paramtype2 == "wallmounted")) then
		return false
	end
	return true
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "closetz:container" then
		return
	end
	if not player or not fields.quit then
		return
	end
	local pn = player:get_player_name()

	if not closetz.container.open_containers[pn] then
		return
	end

	playerz.reset_closet_context(pn)

	closetz.container.container_lid_close(pn)
	return true
end)

function closetz.register_container(name, d)
	local def = table.copy(d)
	def.drawtype = 'mesh'
	def.use_texture_alpha = true
	def.paramtype = "light"
	def.paramtype2 = "facedir"
	def.is_ground_content = false

	def.on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", d.description)
		local inv = meta:get_inventory()
		inv:set_size("closet", 12*1)
	end
	def.can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("closet")
	end
	def.on_rightclick = function(pos, node, clicker)
		minetest.sound_play(def.sound_open, {gain = 0.3, pos = pos, max_hear_distance = 10})
		if not closetz.container.container_lid_obstructed(pos, "above") then
			minetest.swap_node(pos, {
					name = "closetz:" .. name .. "_open",
					param2 = node.param2 })
		end
		minetest.after(0.2, minetest.show_formspec,
				clicker:get_player_name(),
				"closetz:container", closetz.container.get_container_formspec(pos, clicker))
		local player_name = clicker:get_player_name()
		playerz.set_closet_context(player_name, pos)
		closetz.container.open_containers[player_name] = { pos = pos, sound = def.sound_close, swap = name }
	end
	def.on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "closet", drops)
		drops[#drops+1] = "closetz:" .. name
		minetest.remove_node(pos)
		return drops
	end

	local def_opened = table.copy(def)
	local def_closed = table.copy(def)

	def_opened.mesh = "closet_open.obj"
	def_opened.tiles = {"closetz_closet_open.png",}
	def_opened.drop = "closetz:" .. name
	def_opened.groups.not_in_creative_inventory = 1
	def_opened.can_dig = function()
		return false
	end
	def_opened.on_blast = function() end

	minetest.register_node("closetz:" .. name, def_closed)
	minetest.register_node("closetz:" .. name .. "_open", def_opened)

end
