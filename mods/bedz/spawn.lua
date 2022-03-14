minetest.register_on_respawnplayer(function(player)
	local pos_str = player:get_meta():get_string("bedz:bed_pos") --get the bed pos
	if pos_str == "" then
		return false
	end
	local pos = minetest.string_to_pos(pos_str)
	if bedz.check_bed(pos) then --if bed exists
		pos = vector.new(pos.x, pos.y + 1, pos.z)
		player:set_pos(pos)
		return true
	else
		return false
	end
end)
