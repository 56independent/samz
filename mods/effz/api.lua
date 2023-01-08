function effz.create_effect(_type, attached, _time)

    local pos, particles_amount, min_size, max_size, texture, texpool


    if _type == "magic" then
        texpool = {
			{
			name = "effz_sparkle_1x1.png",
			scale = 0.5,
			blend = "add"
			},
			{
			name = "effz_sparkle_3x3.png",
			blend = "add"
			},
			{
			name = "effz_sparkle_5x5.png",
			blend = "add",
			scale = 1.5,
			},
        }
        particles_amount = 20
        pos = {
			min = vector.new(-1,-1,-1),
			max = vector.new(1,1,1),
        }
    end

    minetest.add_particlespawner({
		attached = attached,
        amount = particles_amount or 5,
        time = _time or 1,
		pos = pos,
        minexptime = minexptime or 1,
        maxexptime = maxexptime or 1,
        minsize = min_size,
        maxsize = max_size,
        collisiondetection = false,
        vertical = vertical,
        texpool = texpool or nil,
        glow = glow or 14
    })
end
