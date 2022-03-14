helper = {}
helper.vector = {}
helper.nodebox = {}

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
