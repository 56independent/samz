firez = {}

local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

--Config Vars
local timing = 1
local extinguish_time = 2
local node_range = 60

--Some Helper Functions
local function node_can_inflamed(pos)
	if (helper.node_is_air(pos) or helper.node_is_buildable(pos))
		and helper.in_group(vector.new(pos.x, pos.y -1, pos.z), "flammable") then
			return true
	else
		return false
	end
end

--The Spreading Fire Algorithm-->

local function spread_fire(pos)
	--check for an empty node to spread
	local cells = {{x=0, y=0, z=-1}, {x=-1, y=0, z=0}, {x=-1, y=0, z=-1}, {x=0, y=0, z=1},
		{x=1, y=0, z=0}, {x=1, y=0, z=1}}
	local spread_cells = {}
	--check if node is empty
	for _, value in ipairs(cells) do
		local _value = {}
		_value = vector.add(pos, value)
		local inflamed = false
		if node_can_inflamed(_value) then
			inflamed = true
		else
			--checks if node up or node down
			local y_value_table = {-1, 1}
			local y_value = y_value_table[math.random(1, #y_value_table)]
			local value_1 = vector.new(_value.x, _value.y + y_value, _value.z)
			if node_can_inflamed(value_1) then
				_value = helper.table.deepcopy(value_1)
				inflamed = true
			else
				local value_2 = vector.new(_value.x, _value.y - y_value, _value.z)
				if node_can_inflamed(value_2) then
					_value = helper.table.deepcopy(value_2)
					inflamed = true
				end
			end
		end
		if inflamed then
			spread_cells[#spread_cells+1] = _value
		end
	end
	local _spread_cells = helper.table.shuffle(spread_cells)
	if #_spread_cells > 0 then
		local spread_pos = _spread_cells[math.random(1, #_spread_cells)]
		minetest.set_node(spread_pos, {name = "firez:fire"})
		local meta = minetest.get_meta(pos)
		local _node_range = meta:get_int("firez:node_range")
		_node_range = _node_range - 1
		minetest.get_meta(spread_pos):set_int("firez:node_range", _node_range)
		return true
	else
		return false
	end
end

--The definition of the Fire Node goes here -->

local function extinguish_fire(pos)
	helper.set_to_air(pos)
end

minetest.register_node("firez:fire", {
	description = S("Fire"),
	drawtype = "nodebox",
	node_box = helper.nodebox.fire,
	inventory_image = "firez_fire.png",
	wield_image = "firez_fire.png",
	tiles = {{
		name = "firez_fire_animated.png",
		animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.0}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	liquids_pointable = false,
	light_source = 12,
	groups = {fire=1, igniter=1, deco = 1, float=1},
	drop = "torchz:torch",
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.0, 0.5, 0.0, 0.0},
			{0, -0.5, -0.5, 0, 0.0, 0.5},
		}
	},
	sounds = sound.wood(),

	damage_per_second = 2,
	floodable = true,
	on_rotate = false,

	on_punch = function(pos, node, puncher, pointed_thing)
		helper.set_to_air(pos)
	end,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local node_range = meta:set_int("firez:node_range", node_range)
		meta:set_int("firez:spread", 0)
		meta:set_int("firez:spread_time", extinguish_time * 0.3)
		local node_under = helper.get_node(pos, "under")
		if node_under then
			if node_under.name == "nodez:dirt_with_grass" or node_under.name == "nodez:dirt_with_snow" then
				minetest.add_node(vector.new(pos.x, pos.y-1, pos.z), {name="nodez:dirt_with_burnt_grass"})
			elseif node_under.name == "nodez:ice" then
				minetest.add_node(vector.new(pos.x, pos.y-1, pos.z), {name="nodez:water_source"})
			end
		end
		minetest.get_node_timer(pos):start(timing)
	end,

	on_timer = function(pos, elapsed)

		if minetest.get_node_light(pos, 0.5) == 15 then --is outside?
			local climate_id = climaz.is_inside_climate(pos)
			if climate_id then
				local climate_type = climaz.climates[climate_id].downfall_type
				if climate_type == "rain" or climate_type == "storm" or climate_type == "snow" then
					extinguish_fire(pos)
					return false
				end
			end
		end

		local meta = minetest.get_meta(pos)
		local timer = meta:get_int("firez:timer")
		local spread = helper.number_to_bool(meta:get_int("firez:spread"))
		local spread_time = meta:get_int("firez:spread_time")

		if not(spread) and (timer >= spread_time) then
			local _node_range = meta:get_int("firez:node_range")
			if _node_range > 0 then
				if not spread_fire(pos) then
					return false
				end
			end
			meta:set_int("firez:spread", 1)
		elseif timer >= extinguish_time then
			extinguish_fire(pos)
			return false
		end

		meta:set_int("firez:timer", timer + 1) --by default continue timing-->
		return true
	end
})
