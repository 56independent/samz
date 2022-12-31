helper = {}
helper.vector = {}
helper.nodebox = {}
helper.table = {}
helper.string = {}
helper.array = {}
helper.nodes = {}

--Node Helpers

function helper.in_group(pos, group)
	local node = minetest.get_node_or_nil(pos)
	if node then
		local group_value = minetest.get_item_group(node.name, group)
		if group_value > 0 then
			return group_value
		else
			return false
		end
	else
		return false
	end
end

function helper.get_nodedef_field(nodename, fieldname)
	if not minetest.registered_nodes[nodename] then
		return nil
	end
	return minetest.registered_nodes[nodename][fieldname]
end

function helper.get_node(pos, where)
	if where == "above" then
		pos = vector.new(pos.x, pos.y + 1, pos.z)
	elseif where == "under" then
		pos = vector.new(pos.x, pos.y - 1, pos.z)
	end
	local node = minetest.get_node_or_nil(pos)
	if node then
		return node
	else
		return nil
	end
end

function helper.to_clock(timeofday)
	local seconds = math.round(24000*(timeofday or minetest.get_timeofday())*3.6)
	if seconds <= 0 then
		return "00:00"
	else
		local hours = string.format("%02.f", math.floor(seconds/3600))
		local mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
		--secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
		return hours..":"..mins
	end
end

function helper.what_hour(timeofday)
	local seconds = math.round(24000*(timeofday or minetest.get_timeofday())*3.6)
	if seconds <= 0 then
		return 0
	else
		local hours = math.floor(seconds/3600)
		return hours
	end
end

--Node

function helper.node_is_air(pos, y_offset)
	if y_offset then
		pos = vector.new(pos.x, pos.y + y_offset, pos.z)
	end
	local node = minetest.get_node_or_nil(pos)
	if node and helper.get_nodedef_field(node.name, "drawtype") == "airlike" then
		return true
	else
		return false
	end
end

function helper.node_is_buildable(pos, y_offset)
	local node = minetest.get_node_or_nil(pos)
	if y_offset then
		pos = vector.new(pos.x, pos.y + y_offset, pos.z)
	end
	if node and (helper.get_nodedef_field(node.name, "buildable_to") or helper.node_is_air(pos)) then
		return true
	else
		return false
	end
end

function helper.node_is_soil(pos, y_offset)
	if y_offset then
		pos = vector.new(pos.x, pos.y + y_offset, pos.z)
	end
	return helper.in_group(pos, "soil")
end

function helper.node_is_plow(pos, y_offset)
	if y_offset then
		pos = vector.new(pos.x, pos.y + y_offset, pos.z)
	end
	return helper.in_group(pos, "plow")
end

function helper.node_is_water(pos, y_offset)
	if y_offset then
		pos = vector.new(pos.x, pos.y + y_offset, pos.z)
	end
	local node = minetest.get_node_or_nil(pos)
	if node and minetest.registered_nodes[node.name]
		and (minetest.registered_nodes[node.name]["liquidtype"] == "source"
			or minetest.registered_nodes[node.name]["liquidtype"] == "flowing") then
				return true
	else
		return false
	end
end

function helper.node_is_walkable(pos)
	local node = minetest.get_node_or_nil(pos)
	if node and helper.get_nodedef_field(node.name, "walkable") then
		return true
	else
		return false
	end
end

function helper.node_is_fire(pos, y_offset)
	if y_offset then
		pos = vector.new(pos.x, pos.y + y_offset, pos.z)
	end
	local node = minetest.get_node_or_nil(pos)
	if node and node.name == "firez:fire" then
		return true
	else
		return false
	end
end

function helper.set_to_air(pos)
	minetest.set_node(pos, {name="air"})
end

function helper.node_is_dirt(pos, y_offset)
	if y_offset then
		pos = vector.new(pos.x, pos.y + y_offset, pos.z)
	end
	return helper.in_group(pos, "dirt")
end

--Direction

function helper.get_look_yaw(pos)
	local rotation = minetest.get_node(pos).param2
	if rotation > 3 then
		rotation = rotation % 4 -- Mask colorfacedir values
	end
	if rotation == 1 then
		return math.pi / 2, rotation
	elseif rotation == 3 then
		return -math.pi / 2, rotation
	elseif rotation == 0 then
		return math.pi, rotation
	else
		return 0, rotation
	end
end

function helper.dir_to_compass(dir)
	local angle = math.round(math.deg(math.atan2(dir.z, dir.x)))
	local compass_vector, compass_dir
	if angle >= -45 and angle <= 45 then --East
		compass_vector = vector.new(1, 0, 0)
		compass_dir = "east"
	elseif angle > 45 and angle <= 135 then -- North
		compass_vector = vector.new(0, 0, 1)
		compass_dir = "north"
	elseif angle < -45 and angle >= -135 then -- South
		compass_vector = vector.new(0, 0, -1)
		compass_dir = "south"
	else --West
		compass_vector = vector.new(-1, 0, 0)
		compass_dir = "west"
	end
	return compass_vector, compass_dir
end

-- Nodeboxes

helper.nodebox.flat = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, -0.499, 0.5}, -- Flat Plane (Ground)
	},
}

helper.nodebox.plant = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, -0.499, 0.5}, -- Flat Plane (Ground)
		{-0.5, -0.5, 0.0, 0.5, 0.5, 0.0},
		{0, -0.5, -0.5, 0, 0.5, 0.5},
	}
}

helper.nodebox.plant_normal = { --No ground plane
	type = "fixed",
	fixed = {
		{-0.5, -0.5, 0.0, 0.5, 0.5, 0.0},
		{0, -0.5, -0.5, 0, 0.5, 0.5},
	}
}

helper.nodebox.fire = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, 0.0, 0.5, 0.5, 0.0},
		{0, -0.5, -0.5, 0, 0.5, 0.5},
	}
}

helper.nodebox.flat_v = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, 0.0, 0.5, 0.5, 0.0}, -- Flat Plane Vertical
	},
}

--Tables

function helper.table.is_empty(t)
	local next = next
	if next(t) == nil then
		return true
	else
		return false
	end
end

function helper.table.shallowcopy(original)
	local copy = {}
	for key, value in pairs(original) do
		copy[key] = value
	end
	return copy
end

function helper.table.deepcopy(t) -- deep-copy a table
    if type(t) ~= "table" then return t end
    local meta = getmetatable(t)
    local target = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            target[k] = helper.table.deepcopy(v)
        else
            target[k] = v
        end
    end
    setmetatable(target, meta)
    return target
end

function helper.table.shuffle(t) -- suffles numeric indices
    local len, random = #t, math.random
    for i = len, 2, -1 do
        local j = random(1, i)
        t[i], t[j] = t[j], t[i]
    end
    return t
end

--Nodes

function helper.nodes.adjacent_pos_grid(pos, non_oblique)
	local cells = {{x=0, y=0, z=1}, {x=0, y=0, z=-1}, {x=1, y=0, z=0}, {x=-1, y=0, z=0}}
	local grid = {}
	if not non_oblique then
		cells[#cells+1] = {x=1, y=0, z=1}
		cells[#cells+1] = {x=1, y=0, z=-1}
		cells[#cells+1] = {x=-1, y=0, z=1}
		cells[#cells+1] = {x=-1, y=0, z=-1}
	end
	local _cells = helper.table.shuffle(cells)
	for _, cell_pos in ipairs(_cells) do
		grid[#grid+1] = vector.add(pos, cell_pos)
	end
	return grid
end

function helper.nodes.get_random_adjacent_pos(pos, non_oblique)
	local grid = helper.nodes.adjacent_pos_grid(pos, non_oblique)
	return grid[math.random(1, #grid)]
end

--Strings

function helper.string.split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
	return t
end

function helper.string.uppercase(str)
    return (str:gsub("^%l", string.upper))
end

--Arrays

function helper.array.search(array, value)
   for index, _value in ipairs(array) do
        if _value == value then
            return true
        end
    end
    return false
end

--Conversions

function helper.bool_to_number(value)
	return value == true and 1 or value == false and 0
end

function helper.number_to_bool(value)
	if value > 0 then
		return true
	else
		return false
	end
end

