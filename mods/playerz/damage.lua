minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
	if playerz.is_dead(player) then
		return true --do nothing
	end
	local class = playerz.get_class(player)
	if class == "" then
		return true --do nothing
	end
	playerz.change_hp(player, -damage*playerz.classes[class].attack_damage, "punch")
	local ouch = "ouch"
	if playerz.is_female(player) then
		ouch = "ouch".."_female"
	end
	sound.play("player", player, ouch)
	return true
end)
