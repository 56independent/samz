function boomz.boom_particle_effect(pos, amount)
	minetest.add_particlespawner({
		amount = amount,
		time = 0.5,
		minpos = pos,
		maxpos = pos,
		minvel = vector.new(-2, -2, -2),
		maxvel = vector.new(5, 5, 5),
		minacc = {x=0, y=0, z=0},
		maxacc = {x=0, y=5, z=0},
		minexptime = 1.1,
		maxexptime = 1.5,
		minsize = 1,
		maxsize = 5,
		collisiondetection = false,
		vertical = false,
		texture = "smoke.png",
	})
	minetest.add_particlespawner({
		amount = amount,
		time = 0.5,
		minpos = pos,
		maxpos = pos,
		minvel = vector.new(-1, -1, -1),
		maxvel = vector.new(3, 3, 3),
		minacc = {x=0, y=0, z=0},
		maxacc = {x=0, y=3, z=0},
		minexptime = 1.1,
		maxexptime = 1.5,
		minsize = 1,
		maxsize = 3,
		collisiondetection = false,
		vertical = false,
		texture = "sparkle.png",
	})
end

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
							boomz.boom_particle_effect(node_pos, 3)
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
