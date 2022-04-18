local S, modname = ...

local singleplayer
if minetest.is_singleplayer() then
	singleplayer = true
else
	singleplayer = false
end

local multiplayer_timeofday = nil
local default_hours = 8

local _contexts = {}

local function get_context(name)
    local context = _contexts[name] or {}
    _contexts[name] = context
    return context
end

local function compose_formspec(player_name, await)
	local players_sleeping = 0
	if not(singleplayer) then
		players_sleeping = playerz.count_sleeping()
	end
	local formspec
	if singleplayer or not(await) then
		local context = get_context(player_name)
		local hours = context.hours or tonumber(default_hours)
		local timeofday = minetest.get_timeofday()
		local btn_dawn_dusk, img_dawn_dusk, lbl_dawn_dusk
		if timeofday > 0.2 and timeofday < 0.805 then
			lbl_dawn_dusk = S("Dusk")
			btn_dawn_dusk = "btn_dusk"
			img_dawn_dusk = "moon.png^[transformR180"
		else
			lbl_dawn_dusk = S("Dawn")
			btn_dawn_dusk = "btn_dawn"
			img_dawn_dusk = "sun_icon.png"
		end
		formspec = [[
			formspec_version[5]
			size[6,4.25]
			image[2,0;1,1;clock_white.png]
			label[3,0.5;]]..helper.to_clock()..[[]
			image_button_exit[2,1.75;2,1;;btn_hours;]]..hours.." "..S("Hours")..[[]
			image_button_exit[1.5,3;1,1;]]..img_dawn_dusk..[[;]]..btn_dawn_dusk..[[;]]..lbl_dawn_dusk..[[]
			button_exit[3.5,3;2,1;btn_leave;]]..S("Leave Bed")..[[]
			scrollbaroptions[min=1;max=12;smallstep=1;largestep=12]
			scrollbar[0.5,1;5,0.5;;scrollbar;]]..hours..[[]
		]]
	else --awaiting formspec
		formspec = [[
			formspec_version[5]
			size[6,4.25]
			label[0.5,0.5;]]..S("Players sleeping")..": "..tostring(players_sleeping)..[[]
			label[0.5,1;]]..S("Connected players")..": "..tostring(playerz.count)..[[]
			label[0.5,1.5;]]..S("Required players to sleep")..": "..tostring(math.floor(playerz.count/2)+ 1)..[[]
			button_exit[3.5,3;2,1;btn_leave;]]..S("Leave Bed")..[[]
		]]
	end
	return formspec
end

function bedz.check_bed(pos)
	local node = minetest.get_node_or_nil(pos)
	if (not node) or (minetest.get_node_group(node.name, "bed") == 0) then --not a bed
		return false
	else
		return true
	end
end

local function unmark_bed(pos)
	if bedz.check_bed(pos) then
		minetest.get_meta(pos):set_string("bedside", "") --unmark the bed
	end
end

local function rest_player(player, rest_hours)
	local hp = player:get_hp()
	hp = hp + (rest_hours * 0.5)
	player:set_hp(hp)
end

local function stop_sleep(player)
	local meta = player:get_meta()
	local player_name = player:get_player_name()
	unmark_bed(minetest.string_to_pos(meta:get_string("bedz:bed_pos")))
	playerphysics.remove_physics_factor(player, "speed", "bedz")
	playerphysics.remove_physics_factor(player, "jump", "bedz")
	playerphysics.remove_physics_factor(player, "gravity", "bedz")
	playerz.set_status(player, "normal")
	player:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
	minetest.close_formspec(player_name, "bedz:form")
	playerz.player_attached[player_name] = nil
end

local function awake(player, rest_hours)
	if playerz.get_status(player) == "sleep" then
		stop_sleep(player)
		if rest_hours then
			rest_player(player, rest_hours)
			playerz.change_hunger(player, -(rest_hours*(playerz.max_hunger/playerz.starving_hours))) --decrease hunger
			sound.play("player", player, "bedz_yawn")
		end
		return true
	else
		return false
	end
end

local function close_all_forms()
	for _, _player in ipairs(minetest.get_connected_players()) do
		if playerz.get_status(_player) == "sleep" then
			awake(_player, nil)
			minetest.close_formspec(_player:get_player_name(), "bedz:form")
		end
	end
end

local function calculate_hours(timeofday)
	local current_hour = helper.what_hour()
	--minetest.chat_send_all(tostring(current_hour))
	local hour = helper.what_hour(timeofday)
	--minetest.chat_send_all(tostring(hour))
	local hours
	if (current_hour > hour)  then
		hours = 24 - current_hour + hour
	else
		hours = hour - current_hour
	end
	return tostring(hours)
end

local function multiplayer_sleep()
	local players_sleeping = playerz.count_sleeping()
	local slept
	if multiplayer_timeofday and (players_sleeping > (playerz.count / 2)) then
		local hours = calculate_hours(multiplayer_timeofday)
		minetest.set_timeofday(multiplayer_timeofday)
		for _, _player in ipairs(minetest.get_connected_players()) do
			minetest.chat_send_player(_player:get_player_name(), "You have slept".." "..hours.." ".."hours")
			awake(_player, hours) --awake all players
		end
		multiplayer_timeofday = nil
		slept = true
	else
		slept = false
	end
	return slept, players_sleeping
end

local function sleep(pos, player)
	local player_name = player:get_player_name()
	local meta_bed = minetest.get_meta(pos)

	meta_bed:set_string("bedside", player_name) --mark the bed
	-- physics, eye_offset, etc
	player:set_eye_offset({x = 0, y = -13, z = 0}, {x = 0, y = 0, z = 0})
	local yaw, param2 = helper.get_look_yaw(pos)
	player:set_look_horizontal(yaw)
	local dir = minetest.facedir_to_dir(param2)
	local player_pos = {
		x = pos.x + dir.x / 3,
		y = pos.y + 0.31,
		z = pos.z + dir.z / 3
	}
	playerphysics.add_physics_factor(player, "speed", "bedz", 0)
	playerphysics.add_physics_factor(player, "jump", "bedz", 0)
	playerphysics.add_physics_factor(player, "gravity", "bedz", 0)
	player:set_pos(player_pos)
	player:get_meta():set_string("bedz:bed_pos", minetest.pos_to_string(pos))
	playerz.set_status(player, "sleep")
	playerz.player_attached[player_name] = true
	local await
	if singleplayer or (playerz.count == 1) then
		await = false
	else
		local slept, players_sleeping = multiplayer_sleep()
		if slept then
			return
		end
		if (players_sleeping) == 1 and not(multiplayer_timeofday) then
			await = false
		else
			await = true
		end
	end
	minetest.show_formspec(player_name, "bedz:form", compose_formspec(player_name, await))
end

local function use_bed(pos, player)
	local player_name = player:get_player_name()

	-- Check if player is moving
	if vector.length(player:get_velocity()) > 0.0001 then
		return false, "You have to stop moving before going to bed!"
	end

	--Check if player is attached to an object
	if player:get_attach() then
		return false, "You are already attached to another thing"
	end

	--Check if already in bed or bed occupied
	local bedside = minetest.get_meta(pos):get_string("bedside")

	--Check if really bed occupied. This is a case of a crash when a player is sleeping (no bed unmarking)
	if not(bedside == "") then
		local player_bedside = minetest.get_player_by_name(bedside)
		if not(player_bedside) or not(playerz.get_status(player_bedside) == "sleep")
			or not(minetest.string_to_pos(player_bedside:get_meta():get_string("bedz:bed_pos")) == pos) then
				bedside = ""
				unmark_bed(pos)
		end
	end

	--Check if player is hungry
	if playerz.is_starving(player) then
		return false, S("You are hungry")
	end

	if bedside == player_name then
		return false, S("You are already in bed")
	elseif not(bedside == "") then
		return false, S("This bed is already occupied")
	end

	--Sleep
	sleep(pos, player)
	return true
end

local function place_bed(bed_name, placer, pointed_thing)
	local above_pos = pointed_thing.above
	local bed_dir = helper.dir_to_compass(placer:get_look_dir())
	--minetest.chat_send_all("placer dir: "..minetest.pos_to_string(placer_dir))
	local behind_pos = vector.offset(above_pos, bed_dir.x, bed_dir.y, bed_dir.z)
	local node_behind = minetest.get_node_or_nil(behind_pos)
	if node_behind and helper.get_nodedef_field(node_behind.name, "drawtype") == "airlike" then
		local dir = minetest.dir_to_facedir(placer:get_look_dir()) or 0
		minetest.set_node(above_pos, {name = bed_name, param2 = dir})
		return true
	else
		return false
	end
end

function bedz.register_bed(name, def)

	local bed_name = modname..":"..name

	minetest.register_node(bed_name, {
		description = def.description,
		inventory_image = def.inventory_image or "",
		wield_image = def.wield_image or def.inventory_image,
		drawtype = "mesh",
		mesh = "bedz_simple_bed.obj",
		tiles = def.tiles,
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		stack_max = 1,
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, bed = 1, deco = 1},
		sounds = sound.wood(),
		selection_box = {
			type = "fixed",
			fixed = def.selectionbox,
		},
		on_place = function(itemstack, placer, pointed_thing)
			if place_bed(bed_name, placer, pointed_thing) then
				itemstack:take_item()
			end
			return itemstack
		end,
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local bed_used, msg = use_bed(pos, clicker)
			if not bed_used then
				local player_name = clicker:get_player_name()
				minetest.chat_send_player(player_name, msg)
			end
		end,
		on_construct = function(pos)
			unmark_bed(pos)
		end,
		on_destruct = function(pos)
			local meta = minetest.get_meta(pos)
			local bedside = meta:get_string("bedside")
			if not(bedside == "") then
				local player = minetest.get_player_by_name(bedside)
				if player then
					stop_sleep(player, nil)
				end
			end
		end
	})

	if def.recipe then
		minetest.register_craft({
			output = bed_name,
			type = "shaped",
			recipe = def.recipe
		})
	end

end

minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "bedz:form" then
        return
    end
    local player_name = player:get_player_name()
    local context = get_context(player_name)
    local new_timeofday = nil
    if fields.btn_dawn then
		new_timeofday = 0.23
    elseif fields.btn_dusk then
		new_timeofday = 0.805
    elseif fields.btn_hours then
		local sleep_hours = tonumber(context.hours) or default_hours
		local hours = sleep_hours/24
		local timeofday = minetest.get_timeofday()
		if (timeofday+hours) > 1 then
			timeofday = (timeofday + hours) - 1
		else
			timeofday = timeofday + hours
		end
		new_timeofday = timeofday
	elseif fields.quit then
		awake(player, nil)
		if not singleplayer then
			multiplayer_timeofday = nil
			close_all_forms()
		end
		return
    elseif fields.scrollbar then
		local scrollbar = minetest.explode_scrollbar_event(fields.scrollbar)
		if scrollbar.type == "CHG" then
			context.hours = scrollbar.value
			minetest.show_formspec(player_name, "bedz:form", compose_formspec(player_name))
			return
		end
	end
	if singleplayer or (playerz.count == 1) then
		--singleplayer or only one player in multiplayer
		local hours = calculate_hours(new_timeofday)
		minetest.chat_send_player(player_name, S("You have slept").." "..hours.." "
			..S("hours"))
		minetest.set_timeofday(new_timeofday)
		awake(player, hours)
	else --multiplayer, #players>1
		if new_timeofday then --set the multiplayer new timeofday for the first time
			multiplayer_timeofday = new_timeofday
		end
		local slept = multiplayer_sleep()
		if slept then
			return
		else --awating formspec
			minetest.show_formspec(player_name, "bedz:form", compose_formspec(player_name, true))
		end
	end
end)

--Player Status

minetest.register_on_dieplayer(function(player, reason)
	awake(player, nil)
end)

minetest.register_on_leaveplayer(function(player)
	awake(player, nil)
	_contexts[player:get_player_name()] = nil
end)

minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
	return awake(player, nil)
end)
