local player_hunger = {}

--Time to decrease Hunger
local hunger_tick = 1500
--Time to produce health damage when starving
local hunger_tick_damage = 4

function playerz.save_hunger(player, value)
	player:get_meta():set_int("hunger", value)
	return value
end

function playerz.load_hunger(player)
	local name = player:get_player_name()
	local hunger = player:get_meta():get_int("hunger")
	player_hunger[name] = {
		points = hunger,
		hud_id = nil,
		timer = 0
	}
	return hunger
end

--Setter/Getter

function playerz.set_hunger(player, value)
	local name = player:get_player_name()
	player_hunger[name].points = value
	playerz.hb_change(player, value)
	return value
end

function playerz.get_hunger(player)
	local name = player:get_player_name()
	local hunger = player_hunger[name].points
	return hunger
end

function playerz.reset_hunger(player)
	local name = player:get_player_name()
	local hunger = 20
	player_hunger[name].points = hunger
	playerz.hb_change(player, hunger)
end

function playerz.init_hunger(player)
	local hunger = playerz.save_hunger(player, 20)
	local name = player:get_player_name()
	player_hunger[name] = {
		points = hunger,
		hud_id = nil,
		timer = 0
	}
	return hunger
end

--Save the hunger on leave player
function playerz.remove_hunger(player)
	local name = player:get_player_name()
	playerz.save_hunger(player, player_hunger[name].points)
	player_hunger[name] = nil
end

function playerz.shutdown_hunger(player)
	local name = player:get_player_name()
	playerz.save_hunger(player, player_hunger[name].points)
end

--Hunger Hubbar

function playerz.hb_add(player, hunger)
	local name = player:get_player_name()
	player_hunger[name].hud_id = player:hud_add({
		hud_elem_type = "statbar",
		text= "hunger.png",
		number = hunger,
		direction = 0,
		size = {x = 24, y = 24},
		position = {x = 0.5, y = 1},
		offset = {x = -265, y= -116},
	})
end

function playerz.hb_change(player, hunger)
	local name = player:get_player_name()
	player:hud_change(player_hunger[name].hud_id, "number", hunger)
end

--Hunger Engine

function playerz.hunger(player)
	local name = player:get_player_name()
	local hunger = playerz.get_hunger(player)
	if hunger <= 0 then --hunger damage
		if player_hunger[name].timer >= hunger_tick_damage then
			local new_hp = player:get_hp() - 1
			player:set_hp(new_hp, "hunger")
			player_hunger[name].timer = 0
		else
			player_hunger[name].timer = player_hunger[name].timer + 1
		end
		return
	end
	if player_hunger[name].timer >= hunger_tick then
		hunger = hunger - 1
		playerz.set_hunger(player, hunger)
		player_hunger[name].timer = 0
	else
		player_hunger[name].timer = player_hunger[name].timer + 1
	end
end
