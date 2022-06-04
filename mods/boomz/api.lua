function boomz.boom(pos, radius, player_damage)
	for i = pos.x-radius, pos.x+radius, 1 do
		for j = pos.y-radius, pos.y+radius, 1 do
			for k = pos.z-radius, pos.z+radius, 1 do
				local node_pos = vector.new(i, j, k)
				local dist = vector.distance(pos, node_pos)
				if dist < radius then
					local node = minetest.get_node_or_nil(node_pos)
					if node and not(helper.node_is_air(node_pos)) and not(helper.node_is_water(node_pos))
						and not minetest.is_protected(node_pos, "") then
							minetest.remove_node(node_pos)
							sound.play("pos", node_pos, "boomz_explosion", 20, 1.0)
					end
				end
			end
		end
	end
	for _, obj in ipairs(minetest.get_objects_inside_radius(pos, radius)) do
		if minetest.is_player(obj) then
			playerz.change_hp(obj, -player_damage, "boom")
		end
	end
end
