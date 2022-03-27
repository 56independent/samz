eat = {}

local function eat_particlespawner(user, item_name, itemstack)
	local pos = user:getpos()
	pos.y = pos.y + 1.43
	local texture  = minetest.registered_items[item_name].inventory_image
	local dir = user:get_look_dir()

	minetest.add_particlespawner({
		amount = 8,
		time = 0.1,
		minpos = pos,
		maxpos = pos,
		minvel = {x = dir.x - 1, y = dir.y, z = dir.z - 1},
		maxvel = {x = dir.x + 1, y = dir.y, z = dir.z + 1},
		minacc = {x = 0, y = -5, z = 0},
		maxacc = {x = 0, y = -9, z = 0},
		minexptime = 0.3,
		maxexptime = 0.5,
		minsize = 1.5,
		maxsize = 3,
		texture = "eat_particles.png^"..texture.."^eat_particles.png^[makealpha:255,126,126",
	})
end

function eat.item_eat(itemstack, user, item_name, hp, hunger)
	if user and user:is_player() then
		playerz.change_hp(user, hp or 1, "eat")
		eat_particlespawner(user, item_name, itemstack)
		playerz.change_hunger(user, hunger or 1)
		sound.play("player", user, "eat_chewing")
	end
	itemstack:take_item()
	return itemstack
end
