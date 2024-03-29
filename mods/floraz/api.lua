local S, modname = ...

--Constants
local plant_grow_time = 5

function floraz.register_plant(name, def)

	local plant_name = modname .. ":" .. name

	local groups = def.groups
	groups["plant"] = 1
	groups["snappy"] = 2
	groups["flammable"] = 3
	groups["oddly_breakable_by_hand"] = 3
	groups["choppy"] = 2

	local tile = modname.."_"..name..".png"

	minetest.register_node(plant_name, {
		description = S(def.desc),
		drawtype = "plantlike",
		walkable = false,
		paramtype = "light",
		paramtype2 = "facedir",
		tiles = {tile},
		inventory_image = def.inventory_image or tile,
		wield_image = def.wield_image or def.inventory_image or tile,
		use_texture_alpha = "blend",
		groups = groups,
		selection_box = def.selection_box or {},
		sounds = sound.leaves()
	})
end

function floraz.register_liana(name, def)

	local liana_name = modname .. ":" .. name .. "_liana"

	minetest.register_node(liana_name, {
		description = S(def.desc),
		drawtype = "nodebox",
		walkable = false,
		paramtype = "light",
		paramtype2 = "facedir",
		tiles = {modname.."_"..name.."_liana.png"},
		inventory_image = def.inventory_image or def.tile,
		wield_image = def.wield_image or def.inventory_image or def.tile,
		use_texture_alpha = "clip",
		node_box = helper.nodebox.flat_v,
		groups = {
			snappy = 2, flammable = 3, oddly_breakable_by_hand = 3, choppy = 2, carpet = 1, leafdecay = 3, leaves = 1,
		},
		sounds = sound.leaves()
	})
end

--Growing Plants

local  function check_soil(pos, offset, extra_soil_group)
	if helper.node_is_soil(pos, offset)	then
		return true
	else
		if extra_soil_group then
			if helper.in_group(vector.new(pos.x, pos.y+offset, pos.z), extra_soil_group) then
				return true
			end
		end
		return false
	end
end

local function grow_plant(pos, plant_name, extra_soil_group)
	local new_pos = vector.new(pos.x, pos.y + 1, pos.z)
	if not(helper.node_is_buildable(new_pos)) then
		return false
	end
	minetest.swap_node(new_pos, {name = plant_name, param2 = 1})
	if check_soil(new_pos, -2, extra_soil_group) and helper.node_is_buildable(new_pos, 1) then
		minetest.get_node_timer(new_pos):start(plant_grow_time)
	end
end

local function can_grow(pos, plant_name, extra_soil_group)
	if not(helper.node_is_buildable(pos, 1)) then
		return false
	end
	local node_under = minetest.get_node_or_nil(vector.new(pos.x, pos.y-1, pos.z))
	if check_soil(pos, -1, extra_soil_group)
		or (node_under and node_under.name == plant_name and check_soil(pos, -2, extra_soil_group)) then
			return true
	else
		return false
	end
end

--Dig Up

local function dig_up(pos, node, digger)
	if digger == nil then
		return
	end
	local up_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
	local up_node = minetest.get_node_or_nil(up_pos)
	if up_node and (up_node.name == node.name) then
		minetest.node_dig(up_pos, up_node, digger)
	end
end

--Growing Plant Register

function floraz.register_growing_plant(name, def)

	local plant_name = modname .. ":" .. name

	minetest.register_node(plant_name, {
		description = S(def.desc),
		inventory_image = def.inventory_image or "",
		drawtype = def.drawtype or "normal",
		tiles = def.tiles,
		selection_box = def.selection_box or {},
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "none",
		place_param2 = 1,
		groups = def.groups,
		sounds = def.sounds,
		walkable = def.walkable,

		after_place_node = function(pos, placer, itemstack, pointed_thing)
			if can_grow(pos, plant_name, def.extra_soil_group) then --check if soil or the same plant
				minetest.get_node_timer(pos):start(plant_grow_time)
			end
		end,

		on_timer = function(pos, elapsed)
			grow_plant(pos, plant_name, def.extra_soil_group)
			return false
		end,

		after_dig_node = function(pos, node, metadata, digger)
			if def.dig_up then
				dig_up(pos, node, digger)
			end
		end,

	})
end
