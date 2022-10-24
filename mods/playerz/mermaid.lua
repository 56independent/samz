playerz.register_model("mermaid.b3d", {
	animation_speed = 30,
	textures = {"mermaid_skin.png", "blank.png"},
	animations = {
		-- Standard animations.
		stand = {x = 0,   y = 79},
		lay = {x = 162, y = 166},
		walk = {x = 168, y = 187},
		mine = {x = 189, y = 198},
		walk_mine = {x = 200, y = 219},
		sit = {x = 81,  y = 160},
		swin = {x = 232, y = 280},
		swin_mine = {x = 281, y = 305},
		swin_and_mine = {x = 306, y = 330},
		swin_stand = {x = 0, y = 79},
	},
	collisionbox = {-0.28125, 0.0, -0.28125, 0.28125, 1.5, 0.28125},
	stepheight = 0.6,
	eye_height = 1.47,
	colorize_skin = false,
	disable_cloth = {
		footwear = true,
		underwear = true,
		lower = true,
		upper = true,
	}
})

function playerz.is_mermaid(player)
	if player:get_meta():get_int("mermaid") > 0 then
		return true
	else
		return false
	end
end

function playerz.convert_to_mermaid(player)
	player:get_meta():set_int("mermaid", 1)
	playerz.set_player(player)
	player:set_properties({
		breath_max = 600,
	})
	player:set_breath(600)
end

function playerz.reset_mermaid(player)
	player:get_meta():set_int("mermaid", 0)
	playerz.set_player(player)
	player:set_properties({
		breath_max = 10,
	})
	player:set_breath(10)
end
