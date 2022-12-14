local S = ...

-- Grow Timer

local function start_grow(pos, _time)
	local timer = minetest.get_node_timer(pos)
	timer:start(_time)
end

local function grow_fruit(pos, def)
	local grow_more
	local meta = minetest.get_meta(pos)
	local amount = meta:get_int("farmz:fruit_amount")
	--check for a place to fruit grown
	local grid = helper.nodes.adjacent_pos_grid(pos, true)
	local dirt_cells = {}
	for _, cell_pos in ipairs(grid) do
		if (helper.node_is_air(cell_pos) or helper.node_is_plow(cell_pos)) and helper.node_is_dirt(cell_pos, -1) then
			dirt_cells[#dirt_cells+1] = cell_pos
		end
	end
	local grow_pos
	if helper.table.is_empty(dirt_cells) then
		grow_pos = pos
		grow_more = false
	else
		grow_pos = dirt_cells[math.random(1, #dirt_cells)]
		amount = amount - 1
		if amount == 0 then
			minetest.set_node(pos, {name = "air"})
			grow_more = false
		else
			meta:set_int("farmz:fruit_amount", amount)
			grow_more = true
		end
	end
	minetest.set_node(grow_pos, {name = def.modname..":"..def.fruit.name})
	return grow_more
end

--Plow Node

local function remove_soil(pos)
	if helper.in_group(pos, "soil") then
		minetest.remove_node(pos)
	end
end

minetest.register_node("farmz:plow", {
	description = S("Plowed Soil"),
    drawtype = "nodebox"    ,
    paramtype = "light",
    node_box = helper.nodebox.flat,
    walkable = false,
    tiles = {"farmz_plow.png"},
    buildable_to = true,
    groups = {crumbly = 3, dirt = 1, plow = 1, not_in_creative_inventory = 1},
    sounds = sound.dirt(),
	drop = "", --no drop
    after_destruct = function(pos, oldnode)
		--destroy the soil under
		local node = minetest.get_node_or_nil(pos)
		if node and node.name == "air" then
			remove_soil({x=pos.x, y=pos.y-1, z=pos.z})
		end
    end
})

farmz.hoe_use = function(itemstack, user, pointed_thing)
	-- check if pointing at a node
	if not(pointed_thing) or (pointed_thing.type ~= "node") then
		return
	end
	local node_under = minetest.get_node(pointed_thing.under)
	local pos_above = {x=pointed_thing.under.x, y=pointed_thing.under.y+1, z=pointed_thing.under.z}
	local node_above = minetest.get_node(pos_above)

	-- return if any of the nodes is not registered
	if not(minetest.registered_nodes[node_under.name]) or not minetest.registered_nodes[node_above.name] then
		return
	end

	-- check if the node above the pointed thing is air
	if node_above.name ~= "air" then
		return
	end

	-- check if pointing at soil
	if minetest.get_item_group(node_under.name, "soil") ~= 1 then
		return
	end

	local player_name = user and user:get_player_name() or ""

	if minetest.is_protected(pointed_thing.under, player_name) then
		minetest.record_protection_violation(pointed_thing.under, player_name)
		return
	end

	if minetest.is_protected(pointed_thing.above, player_name) then
		minetest.record_protection_violation(pointed_thing.above, player_name)
		return
	end

	-- put the above node into soil and play sound
	minetest.set_node(pos_above, {name = "farmz:plow"})
	sound.play("pos", pos_above, "sound_dig_crumbly", 7, 0.3)

	return itemstack
end

function farmz.register_hoe(name, def)

	local hoe_name = def.modname..":"..name

	minetest.register_tool(hoe_name, {
		description = def.description,
		inventory_image = def.inventory_image,
		wield_image = def.wield_image or def.inventory_image,
		on_use = function(itemstack, user, pointed_thing)
			return farmz.hoe_use(itemstack, user, pointed_thing)
		end,
		groups = {hoe = 1, tool = 4},
		sound = {breaks = "default_tool_breaks"},
	})

	if def.recipe then
		minetest.register_craft({
			output = hoe_name,
			type = "shaped",
			recipe = def.recipe
		})
	end
end

function farmz.register_seed(modname, name, description, product_name, grow_time, sprout)

	local seed_name = product_name.."_seed"
	local seed_name_soil = seed_name.."_soil"
	local seed_texture = modname.."_"..name.."_seed.png"

	minetest.register_craftitem(seed_name, {
		description = S("@1 Seed", S(description)),
		inventory_image = seed_texture,
		groups = {seed = 1},
		on_use = function(itemstack, user, pointed_thing)
			-- check if pointing at a node
			if not(pointed_thing) or (pointed_thing.type ~= "node") then
				return
			end
			local pos = pointed_thing.under
			local node = minetest.get_node(pos)
			-- return if any of the nodes is not registered
			if not(minetest.registered_nodes[node.name]) then
				return
			end
			if node.name == "farmz:plow" then
				minetest.set_node(pos, {name = seed_name_soil})
				itemstack:take_item(1)
				start_grow(pos, grow_time)
			end
			return itemstack
		end
	})

	minetest.register_node(seed_name_soil, {
		description = S(description).." ".."("..S("Seed Soil")..")",
		drawtype = "nodebox",
		paramtype = "light",
		walkable = false,
		node_box = helper.nodebox.flat,
		tiles = {"farmz_plow.png^"..seed_texture},
		buildable_to = true,
		groups = {crumbly = 3, dirt = 1, plow = 1, not_in_creative_inventory = 1},
		sounds = sound.dirt(),

		after_place_node = function(pos, placer, itemstack, pointed_thing)
			start_grow(pos, grow_time)
		end,

		on_timer = function(pos)
			local node_name = product_name
			if sprout then
				node_name = node_name .. "_sprout"
			end
			minetest.set_node(pos, {name = node_name})
			start_grow(pos, grow_time)
			return false
		end,

		after_destruct = function(pos, oldnode)
			--destroy the soil under
			local node = minetest.get_node_or_nil(pos)
			if node and node.name == "air" then
				remove_soil({x=pos.x, y=pos.y-1, z=pos.z})
			end
		end
	})

	return seed_name
end

local function register_craft(modname, product_name, craft)

	local craft_name = modname..":"..craft.name

	minetest.register_craftitem(craft_name, {
		description = S(craft.description),
		inventory_image = modname.."_"..craft.name..".png",
		groups = craft.groups,
	})

	local recipe = {{}, {}}
	local row = 1
	local ingredient = ""
	for i = 1, 4 do
		if i == 3 then
			row = 2
		end
		if i <=  craft.input_amount then
			ingredient = product_name
		else
			ingredient = ""
		end
		recipe[row][#recipe[row]+1] = ingredient
	end
	minetest.register_craft({
		output = craft_name.." "..tostring((craft.output_amount or 1)),
		type = "shaped",
		recipe = recipe,
	})
end

local function register_product(name, product_name, def)
	if def.fruit then
		local fruit_name = def.modname..":"..def.fruit.name
		minetest.register_node(fruit_name, {
			description = S(def.fruit.description),
			inventory_image = def.fruit.inventory_image or "",
			wield_image = def.fruit.wield_image or def.inventory_image or "",
			drawtype = "normal",
			paramtype = "light",
			walkable = true,
			tiles = def.fruit.tiles or {},
			groups = def.fruit.groups or {},

			on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
				if def.fruit.shears then
					if clicker:get_wielded_item():get_name() == "toolz:shears_steel" then
						minetest.set_node(pos, {name=def.fruit.shears})
					end
				end
			end
		})
		if def.fruit.craft then
			register_craft(def.modname, fruit_name, def.fruit.craft)
		end
	else
		minetest.register_craftitem(product_name , {
			description = S(def.description),
			inventory_image = def.modname.."_"..name..".png",
			groups = def.groups_product,
		})
	end
end

function farmz.register_plant(name, def)

	local product_name = def.modname..":"..name

	local seed_name = farmz.register_seed(def.modname, name, def.description, product_name, def.grow_time,
		true)

	for i = 1,2 do
		local register
		local description
		local _plant_name
		local texture
		local drop

		local groups_plant = {}
		groups_plant["crumbly"] = 1
		groups_plant["plant"] = 1
		groups_plant["not_in_creative_inventory"] = 1

		if i == 1 then --normal plant

			if not def.only_register_sprout then

				register_product(name, product_name, def)

				_plant_name = product_name.."_plant"
				texture = def.modname.."_"..name.."_plant.png"
				description = S("@1 Plant", S(def.description))
				if not def.drop then
					local drop_number = def.drop_number or 1
					drop = product_name.." "..drop_number
				else
					drop = def.drop
				end
				groups_plant["sprout"] = nil
				register = true
			else
				register = false
			end
		else --sprout
			_plant_name = product_name.."_sprout"
			texture = def.modname.."_"..name.."_sprout.png"
			description = S("@1 Plant", S(def.description)).." ".."("..S("Sprout")..")"
			drop = ""
			groups_plant["sprout"] = 1
			register = true
		end

		if register then
			minetest.register_node(_plant_name, {
				description = description,
				inventory_image = def.inventory_image or texture,
				wield_image = def.wield_image or def.inventory_image or texture,
				drawtype = "nodebox",
				paramtype = "light",
				walkable = false,
				node_box = helper.nodebox.plant,
				tiles = {
					"farmz_plow.png",
					"farmz_plow.png",
					texture,
				},
				selection_box = {
					type = "fixed",
					fixed = def.box,
				},
				drop = drop,
				buildable_to = true,
				groups = groups_plant,
				sounds = sound.dirt(),

				after_place_node = function(pos, placer, itemstack, pointed_thing)
					if i == 2 then
						start_grow(pos, def.grow_time)
					elseif i ==1 and def.fruit then
						local meta = minetest.get_meta(pos)
						meta:set_int("farmz:fruit_amount", def.fruit.amount or 1)
						start_grow(pos, def.fruit.grow_time or 5)
					end
				end,

				on_construct = function(pos)
					if i ==1 and def.fruit then
						local meta = minetest.get_meta(pos)
						meta:set_int("farmz:fruit_amount", def.fruit.amount or 1)
						start_grow(pos, def.fruit.grow_time or 5)
					end
				end,

				on_timer = function(pos)
					if i == 2 then --grow plant
						local plant_name = product_name
						if not def.only_register_sprout then
							plant_name =  plant_name .. "_plant"
						end
						minetest.set_node(pos, {name = plant_name})
						return false
					else --grow fruit
						local grow_more = grow_fruit(pos, def)
						return grow_more
					end
				end,

				after_dig_node = function(pos, oldnode, oldmetadata, digger)
					--minetest.chat_send_all(_plant_name)
					--minetest.chat_send_all(tostring(minetest.get_item_group(_plant_name, "sprout")))
					if def.gather and (minetest.get_item_group(_plant_name, "sprout") == 0) then
						minetest.set_node(pos, {name = product_name.."_sprout"})
					end
				end,

				after_destruct = function(pos, oldnode)
					--destroy the soil under
					local node = minetest.get_node_or_nil(pos)
					if node and node.name == "air" then
						minetest.swap_node(pos, {name="farmz:plow"})
					end
				end
			})
		end
	end

	if def.craft then
		register_craft(def.modname, product_name, def.craft)
	end

	if def.craft_seed then
		local input
		if def.craft_seed.input == "craft" then
			input = def.modname..":"..def.craft.name
		elseif def.craft_seed.input == "product" then
			input = product_name
		end
		local recipe = {
			{input, ""},
			{"", ""}
		}
		minetest.register_craft({
			output = seed_name.." "..tostring((def.craft_seed.output_amount or 1)),
			type = "shaped",
			recipe = recipe,
		})
	end

end
