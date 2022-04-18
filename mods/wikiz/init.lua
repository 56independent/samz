wikiz = {}

local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

local craft_items = minetest.registered_items

local function render_crafts(crafts, page_no)

	local render = ""
	local row = 1
	local col = 0

	--Pagination
	local items_count = #crafts
	local items_per_page = 24
	local total_pages = math.floor((items_count + items_per_page - 1) / items_per_page)
	local item_start = (page_no * items_per_page) - (items_per_page - 1)
	local item_end = math.min(item_start + items_per_page - 1, items_count)

	--local total_crafts = #crafts
	for i = item_start, item_end do
		local craft = crafts[i]
		render = render .. "item_image_button["..tostring(col)..","..tostring(row)..";1,1;"..craft.name
			..";"..craft.name..";]"
		col = col + 1
		if col == 8 then
			col = 0
			row = row + 1
		end
	end

	--NavPag
	if total_pages > 1 then
		if page_no > 1 then
			render = render .."button[2,4;1,1;btn_previous_craft;<<]"
		end
		render = render .."label[3.25,4.25;"..tostring(page_no).." / "..tostring(total_pages).."]"
		if page_no < total_pages then
			render = render .."button[4,4;1,1;btn_next_craft;>>]"
		end
	end
	return render
end

local function create_inv_cube(tiles)
	local inv_cube = "[inventorycube"
	local tile_top, tile_left, tile_right
	tile_top = tiles[1]
	if tiles[3] then
		tile_right = tiles[3]
	else
		tile_right = tile_top
	end
	if tiles[6] then
		tile_left = tiles[6]
	else
		tile_left = tile_top
	end
	inv_cube = inv_cube.."{"..tile_top.."{"..tile_left.."{"..tile_right
	return inv_cube
end

local function render_recipes(item_name, recipe_no)
	local render = ""
	local row = 0
	local col = 0
	local row_offset = 6
	local col_offset = 3
	local recipes = minetest.get_all_craft_recipes(item_name)
	if recipes then
		local recipe = recipes[recipe_no]
		local items = recipe.items
		local label_row_offset = -0.5

		--Type of recipe, "normal, "cooking" or fuel
		local type = recipe.type
		local type_img
		if type == "normal" then
			type_img = "hand.png"
		elseif type == "cooking" then
			type_img = "furnz_furnace_front_active.png"
		else --fuel
			type_img = ""
		end
		render = render .."image["..tostring(col+col_offset-2)..","..tostring(row+row_offset)..";1,1;"
						..type_img.."]"

		--Width; 0=shapeless, 3=shaped
		local width = recipe.width
		local width_str
		if type == "cooking" then
			width_str = "cooking"
		elseif width == 0 then
			width_str = "unordered"
		elseif width == 3 then
			width_str = "ordered"
		else
			width_str = "unordered"
		end
		render = render .."label["..tostring(col+col_offset-2)..","..tostring(row+row_offset+1)
				..";"..S(width_str).."]"

		--Output
		local output = helper.string.split(recipe.output)
		local output_no = output[2] or 1
		render = render
			.."image["..tostring(col+col_offset+2)..","..tostring(row+row_offset+0.5)..";1,1;right_arrow.png]"
		local output_img
		local itemtype = craft_items[item_name].type
		local drawtype = craft_items[item_name].drawtype
		if (itemtype == "node") and (drawtype=="normal") then
			output_img = create_inv_cube(craft_items[item_name].tiles)
		else
			output_img = craft_items[item_name].inventory_image
		end
		if not(output_img == "") then
			render = render .."image["..tostring(col+col_offset+3)..","..tostring(row+row_offset+0.5)..";1,1;"..output_img
				.."]"
		else
			render = render .."label["..tostring(col+col_offset+3)..","..tostring(row+row_offset+0.75)..";"..item_name
				.."]"
		end
		if output_no then
			render = render .."label["..tostring(col+col_offset+3+0.25)..","..tostring(row+row_offset+0.5+1)
			..";"..tostring(output_no).."]"
		end

		--Recipe Items
		for i= 1, 4 do
			local item = items[i]
			local element_render, prefix, name
			if not item then
				prefix = "empty"
			else
				prefix = string.sub(item, 1, 6)
				name = string.sub(item, 7, string.len(item))
			end
			if prefix == "empty" then
				if not(type=="cooking") and not(width_str == "unordered") then
					element_render = "textarea["..tostring(col+col_offset+0.375)..","..tostring(row+row_offset+0.25)
						..";1,1;;"..S(prefix)..";]"
				else
					element_render =  ""
				end
			elseif prefix == "group:" then
				element_render = "textarea["..tostring(col+col_offset+0.25)..","..tostring(row+row_offset)..";1,1;;"
					..S(prefix).."\n"..S(name)..";]"
			else
				local desc = craft_items[item].description or ""
				if craft_items[item].type == "node" and craft_items[item].drawtype=="normal" then
					local node_img = create_inv_cube(craft_items[item].tiles)
					element_render = "image["..tostring(col+col_offset)..","..tostring(row+row_offset)..";1,1;"
						.. node_img.."]"
					element_render = element_render.."textarea["..tostring(col+col_offset+0.25)..","
					..tostring(row+row_offset+label_row_offset)..";1,0.5;;"..desc..";]"
				else
					element_render = "image["..tostring(col+col_offset)..","..tostring(row+row_offset)..";1,1;"
						..(craft_items[item].inventory_image or "blank.png").."]"
					element_render = element_render.."textarea["..tostring(col+col_offset+0.25)..","
					..tostring(row+row_offset+label_row_offset)..";1,0.5;;"..desc..";]"
				end
			end
			render = render..element_render
			col = col + 1
			if col == 2 then
				label_row_offset = label_row_offset + 1.5
				row = row + 1
				col = 0
			end
		end
		--Nav bar
		local recipe_count = #recipes
		if recipe_count > 1 then
			if recipe_no > 1 then
				render = render .."button["..tostring(col_offset-3)..","..tostring(row_offset+1.5)
					..";1,1;btn_previous_recipe;<<]"
			end
			render = render .."label["..tostring(col_offset-2)..","..tostring(row_offset+1.625)
				..";"..tostring(recipe_no).." / "..tostring(recipe_count).."]"
			if recipe_no < recipe_count then
				render = render .."button["..tostring(col_offset-1.5)..","..tostring(row_offset+1.5)
					..";1,1;btn_next_recipe;>>]"
			end
		end
	end
	return render
end

local function create_form(player)
	local context = sfinv.get_or_create_context(player)
	return [[
		image_button[0,0;1,1;;btn_build;]]..S("Build")..[[;;]
		image_button[1,0;1,1;;btn_deco;]]..S("Deco")..[[;;]
		image_button[2,0;1,1;;btn_food;]]..S("Food")..[[;;]
		image_button[3,0;1,1;;btn_ore;]]..S("Ores")..[[;;]
		image_button[4,0;1,1;;btn_pottery;]]..S("Pottery")..[[;;]
		image_button[5,0;1,1;;btn_tool;]]..S("Tools")..[[;;]
		image_button[6,0;1,1;;btn_vessel;]]..S("Vessels")..[[;;]
		image_button[7,0;1,1;;btn_weapon;]]..S("Weapons")..[[;;]
		]]..(context.recipes or "")..[[
		]]..(context.crafts or "")..[[
	]]
end

local function get_crafts(group)
	local crafts = {}
	--minetest.get_all_craft_recipes(query_item)
	for name, def in pairs(craft_items) do
		if minetest.get_item_group(name, group) > 0 then
			local recipe = minetest.get_all_craft_recipes(name)
			crafts[#crafts+1] = {name = name, def = def, recipe = recipe}
		end
	end
	return crafts
end

sfinv.register_page("wiki", {
	title = S("Wiki"),
	get = function(self, player, context)
		local _context = sfinv.get_or_create_context(player)
		--_context.craft_page = 1
		sfinv.set_context(player, _context)
		return sfinv.make_formspec(player, context, create_form(player), false)
	end,
	on_player_receive_fields = function(self, player, context, fields)
		if not fields then
			return
		end
		local _context = sfinv.get_or_create_context(player)
		for key, value in pairs(fields) do
			local prefix = string.sub(key, 1, 4)
			if prefix == "quit" then
				return
			end
			if not(prefix=="btn_") then
				_context.item_name = key
				_context.recipe_no = 1
				_context.recipes = render_recipes(_context.item_name, _context.recipe_no)
			else
				if fields.btn_previous_recipe or fields.btn_next_recipe then
					if fields.btn_previous_recipe then
						_context.recipe_no = _context.recipe_no - 1
					else
						_context.recipe_no = _context.recipe_no + 1
					end
					_context.recipes = render_recipes(_context.item_name, _context.recipe_no)
				else
					local group
					if not _context.craft_page then
						_context.craft_page = 1
					end
					if fields.btn_previous_craft or fields.btn_next_craft then
						if fields.btn_previous_craft then
							_context.craft_page = _context.craft_page - 1
						else
							_context.craft_page = _context.craft_page + 1
						end
						group = _context.group
					else
						group = string.sub(key, 5, string.len(key))
						_context.group = group
						_context.craft_page = 1
					end
					local crafts = get_crafts(group)
					if crafts then
						_context.crafts = render_crafts(crafts, _context.craft_page)
					end
				end
			end
		end
		--minetest.chat_send_all(tostring(_context.craft_page))
		sfinv.set_context(player, _context)
		sfinv.set_page(player, "wiki")
	end,
})
