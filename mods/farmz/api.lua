local S, modname = ...

-- Grow Timer

local function start_grow(pos, _time)
	local timer = minetest.get_node_timer(pos)
	timer:start(_time)
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
	minetest.sound_play("default_dig_crumbly", {
		pos = pointed_thing.under,
		gain = 0.5,
	}, true)

	return itemstack
end

function farmz.register_hoe(name, def)
	local hoe_name = modname..":"..name
	minetest.register_tool(hoe_name, {
		description = def.description,
		inventory_image = def.inventory_image,
		wield_image = def.wield_image or def.inventory_image,
		on_use = function(itemstack, user, pointed_thing)
			return farmz.hoe_use(itemstack, user, pointed_thing)
		end,
		groups = def.groups,
		sound = {breaks = "default_tool_breaks"},
	})
end

function farmz.register_plant(name, def)
	local plant_name = modname..":"..name
	for i = 1,2 do
		local description = ""
		local _type = ""
		local _plant_name = ""
		local texture = modname.."_"..name
		if i == 1 then
			_type = "plant"
			_plant_name = plant_name.."_plant"
			texture = modname.."_"..name.."_plant.png"
			description = def.description.." "..S("Plant")
		else
			_type = "sprout"
			_plant_name = plant_name.."_sprout"
			texture = modname.."_"..name.."_sprout.png"
			description = def.description.." "..S("Plant").." ".."("..S("Sprout")..")"
		end
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
			buildable_to = true,
			groups = {crumbly = 1, plant = 1, not_in_creative_inventory = 1},
			sounds = sound.dirt(),

			after_place_node = function(pos, placer, itemstack, pointed_thing)
				if i == 2 then
					start_grow(pos, def.grow_time)
				end
			end,

			on_timer = function(pos)
				minetest.set_node(pos, {name = plant_name.."_plant"})
				return false
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
	local seed_name = plant_name.."_seed"
	local seed_name_soil = seed_name.."_soil"
	local seed_texture = modname.."_"..name.."_seed.png"

	minetest.register_craftitem(seed_name, {
		description = def.description.." ".."("..S("Seed")..")",
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
				start_grow(pos, def.grow_time)
			end
			itemstack:take_item(1)
			return itemstack
		end
	})

	minetest.register_node(seed_name_soil, {
		description = def.description.." ".."("..S("Seed Soil")..")",
		drawtype = "nodebox",
		paramtype = "light",
		walkable = false,
		node_box = helper.nodebox.flat,
		tiles = {"farmz_plow.png^"..seed_texture},
		buildable_to = true,
		groups = {crumbly = 3, dirt = 1, plow = 1, not_in_creative_inventory = 1},
		sounds = sound.dirt(),

		after_place_node = function(pos, placer, itemstack, pointed_thing)
			start_grow(pos, def.grow_time)
		end,

		on_timer = function(pos)
			minetest.set_node(pos, {name = plant_name.."_sprout"})
			start_grow(pos, def.grow_time)
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
end
