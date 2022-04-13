helper = {}
helper.vector = {}
helper.nodebox = {}
helper.table = {}

function helper.in_group(pos, group)
	local node = minetest.get_node_or_nil(pos)
	if (not node) or (minetest.get_node_group(node.name, group) == 0) then
		return false
	else
		return true
	end
end

function helper.get_nodedef_field(nodename, fieldname)
	if not minetest.registered_nodes[nodename] then
		return nil
	end
	return minetest.registered_nodes[nodename][fieldname]
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

--Air

function helper.node_is_air(pos, offset)
	if offset then
		if offset == "above" then
			pos = vector.new(pos.x, pos.y+1, pos.z)
		elseif offset == "under" then
			pos = vector.new(pos.x, pos.y-1, pos.z)
		end
	end
	local node = minetest.get_node_or_nil(pos)
	if node and helper.get_nodedef_field(node.name, "drawtype") == "airlike" then
		return true
	else
		return false
	end
end

function helper.node_is_water(pos, offset)
	if offset then
		if offset == "above" then
			pos = vector.new(pos.x, pos.y+1, pos.z)
		end
	end
	local node = minetest.get_node_or_nil(pos)
	if node and minetest.registered_nodes[node.name]["liquidtype"] == "source" or
			minetest.registered_nodes[node.name]["liquidtype"] == "flowing" then
				return true
	else
		return false
	end
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
		{-0.5, -0.5, -0.5, 0.5, -0.499, 0.5}, -- Flat Plane
	},
}

helper.nodebox.plant = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, -0.499, 0.5}, -- Flat Plane
		{-0.5, -0.5, 0.0, 0.5, 0.5, 0.0},
		{0, -0.5, -0.5, 0, 0.5, 0.5},
	}
}

--Tables

function helper.table_shallowcopy(original)
	local copy = {}
	for key, value in pairs(original) do
		copy[key] = value
	end
	return copy
end

function helper.table_deepcopy(t) -- deep-copy a table
    if type(t) ~= "table" then return t end
    local meta = getmetatable(t)
    local target = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            target[k] = helper.table_deepcopy(v)
        else
            target[k] = v
        end
    end
    setmetatable(target, meta)
    return target
end

