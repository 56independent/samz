-- Minetest 0.4 mod: player
-- See README.txt for licensing and other information.

-- Load support for MT game translation.
local S = minetest.get_translator("playerz")

playerz = {}

-- Player animation blending
-- Note: This is currently broken due to a bug in Irrlicht, leave at 0
local animation_blend = 0

playerz.registered_models = {}

-- Local for speed.
local models = playerz.registered_models

function playerz.register_model(name, def)
	models[name] = def
end

-- Player stats and animations
local player_textures = {}
local player_anim = {}
local player_sneak = {}
playerz.player_attached = {}
-- Localize for better performance.
local player_attached = playerz.player_attached
playerz.count = 0 --Total number of connected players

function playerz.get_animation(player)
	local name = player:get_player_name()
	return {
		model = playerz.get_model(player),
		textures = player_textures[name],
		animation = player_anim[name],
	}
end

--Hp

function playerz.change_hp(player, value, reason)
	local hp = player:get_hp()
	hp = hp + value
	player:set_hp(hp, reason or "")
	return hp
end

--Helper Functions

function playerz.is_dead(player)
	if player:get_hp() <= 0 then
		return true
	else
		return false
	end
end

function playerz.is_attached(player)
	if player_attached[player:get_player_name()] then
		return true
	else
		return false
	end
end

function playerz.set_gender(player, gender)
	if not(gender) or gender == "random" then
		if math.random(2) == 1 then
			gender = "male"
		else
			gender = "female"
		end
	end
	player:get_meta():set_string("gender", gender)
	return gender
end

function playerz.get_gender(player)
	return player:get_meta():get_string("gender")
end

function playerz.is_male(player)
	if playerz.get_gender(player) == "male" then
		return true
	else
		return false
	end
end

function playerz.is_female(player)
	if playerz.get_gender(player) == "female" then
		return true
	else
		return false
	end
end

function playerz.get_gender_model(gender)
	local model = "character.b3d"
	return model
end

function playerz.get_status(player)
	return player:get_meta():get_string("playerz:status")
end

function playerz.set_status(player, status)
	return player:get_meta():set_string("playerz:status", status)
end

function playerz.set_base_texture(player, gender)
	local meta = player:get_meta()
	meta:set_string("base_texture", gender)
end

minetest.register_chatcommand("toggle_gender", {
	description = S("Change the gender, from male to female or viceversa"),
    func = function(name, param)
		local player = minetest.get_player_by_name(name)
		local meta = player:get_meta()
		local old_gender = playerz.get_gender(player)
		if old_gender then
			local new_gender
			if old_gender == "male" then
				new_gender = "female"
			else
				new_gender = "male"
			end
			meta:set_string("gender", new_gender)
			playerz.update_model(player, playerz.get_gender_model(new_gender), true)
			local gender_model = playerz.get_gender_model(new_gender)
			local cloth = playerz.compose_cloth(player)
			playerz.registered_models[gender_model].textures[1] = cloth
			playerz.set_textures(player, models[gender_model].textures)
			local new_gender_cap = new_gender:gsub("^%l", string.upper)
			minetest.chat_send_player(name, S("Your gender is changed to").." "..S(new_gender_cap)..".")
		end
    end,
})

--converts yaw to degrees
local function yaw_to_degrees(yaw)
	return(yaw * 180.0 / math.pi)
end

local last_look = {}

local function move_head(player, on_water)
	local pname = player:get_player_name()
	local look_at_dir = player:get_look_dir()
	local lastlook = last_look[pname]
	local anim = player_anim[pname] or ""
	local anim_base = string.sub(anim, 1, 4)
	--apply change only if the pitch changed
	if lastlook and look_at_dir.y == lastlook.dir.y and
	   anim_base == lastlook.anim then
		return
	else
		last_look[pname] = {}
		last_look[pname].dir = look_at_dir
		last_look[pname].anim = anim_base
	end
	local pitch = yaw_to_degrees(math.asin(look_at_dir.y))
	if pitch > 70 then pitch = 70 end
	if pitch < -50 then pitch = -50 end
	if anim_base == "swin" or on_water then
		pitch = pitch + 70
	end
	local head_rotation = {x= pitch, y= 0, z= 0} --the head movement {pitch, yaw, roll}
	local head_offset
	if minetest.get_modpath("3d_armor") ~= nil then
		head_offset = 6.75
	else
		head_offset = 6.3
	end
	local head_position = {x=0, y= head_offset, z=0}
	player:set_bone_position("Head", head_position, head_rotation) --set the head movement
end

--Save/grab Model
function playerz.get_model(player)
	return player:get_meta():get_string("playerz:model")
end

function playerz.set_model(player, model)
	return player:get_meta():set_string("playerz:model", model)
end

-- Called when a player's appearance needs to be updated
function playerz.update_model(player, model_name, force)
	local name = player:get_player_name()
	local model = models[model_name]
	if model then
		if playerz.get_model(player) == model_name and not force then
			return
		end
		player:set_properties({
			mesh = model_name,
			textures = player_textures[name] or model.textures,
			visual = "mesh",
			visual_size = model.visual_size or {x = 1, y = 1},
			collisionbox = model.collisionbox or {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
			stepheight = model.stepheight or 0.6,
			eye_height = model.eye_height or 1.47,
		})
		playerz.set_animation(player, "stand")
	else
		player:set_properties({
			textures = {"player.png", "player_back.png"},
			visual = "upright_sprite",
			visual_size = {x = 1, y = 2},
			collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.75, 0.3},
			stepheight = 0.6,
			eye_height = 1.625,
		})
	end
	playerz.set_model(player, model_name)
end

function playerz.set_textures(player, textures)
	local name = player:get_player_name()
	local model = models[playerz.get_model(player)]
	local model_textures = model and model.textures or nil
	player_textures[name] = textures or model_textures
	player:set_properties({textures = textures or model_textures})
end

function playerz.set_animation(player, anim_name, speed)
	local name = player:get_player_name()
	if player_anim[name] == anim_name then
		return
	end
	local player_model = playerz.get_model(player)
	local model = player_model and models[player_model]
	if not (model and model.animations[anim_name]) then
		return
	end
	local anim = model.animations[anim_name]
	player_anim[name] = anim_name
	player:set_animation(anim, speed or model.animation_speed, animation_blend)
end

-- Localize for better performance.
local player_set_animation = playerz.set_animation

-- Prevent knockback for attached players
local old_calculate_knockback = minetest.calculate_knockback
function minetest.calculate_knockback(player, ...)
	if player_attached[player:get_player_name()] or playerz.is_sleeping(player)
		or playerz.is_sit(player)then
			return 0
	end
	return old_calculate_knockback(player, ...)
end

-- Check each player and apply animations
local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	for _, player in pairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local model_name = playerz.get_model(player)
		local model = model_name and models[model_name]
		if model and not player_attached[name] then
			local controls = player:get_player_control()
			local animation_speed_mod = model.animation_speed or 30

			-- Determine if the player is sneaking, and reduce animation speed if so
			if controls.sneak then
				animation_speed_mod = animation_speed_mod / 2
			end

			local on_water
			--Determine if the player is in a water node
			local player_pos = player:get_pos()
			local node_name = minetest.get_node(player_pos).name
			if minetest.registered_nodes[node_name] then
				if minetest.registered_nodes[node_name]["liquidtype"] == "source" or
					minetest.registered_nodes[node_name]["liquidtype"] == "flowing" then
						local player_pos_below = {x= player_pos.x, y= player_pos.y-1, z= player_pos.z}
						local node_name_below = minetest.get_node(player_pos_below).name
						local player_pos_above = {x= player_pos.x, y= player_pos.y+1, z= player_pos.z}
						local node_name_above = minetest.get_node(player_pos_above).name
						if minetest.registered_nodes[node_name_below] and minetest.registered_nodes[node_name_above] then
							local node_below_is_liquid
							if minetest.registered_nodes[node_name_below]["liquidtype"] == "source" or
								minetest.registered_nodes[node_name_below]["liquidtype"] == "flowing" then
									node_below_is_liquid = true
							else
									node_below_is_liquid = false
							end
							local node_above_is_liquid
							if minetest.registered_nodes[node_name_above]["liquidtype"] == "source" or
								minetest.registered_nodes[node_name_above]["liquidtype"] == "flowing" then
									node_above_is_liquid = true
							else
									node_above_is_liquid = false
							end
							local node_above_is_air
							if minetest.registered_nodes[node_name_above] == "air" then
								node_above_is_air = true
							else
								node_above_is_air = false
							end
							if	((node_below_is_liquid) and not(node_above_is_air)) or
								(not(node_below_is_liquid) and node_above_is_liquid) then
								on_water = true
							else
								on_water = false
							end
						else
							on_water = true
						end
				else
						on_water = false
				end
			end

			--Set head pitch if not on singleplayer and first person view
			--minetest.chat_send_all(tostring(player:get_fov()))
			--if not(minetest.is_singleplayer() and (player:get_fov() == 0)) then
				--minetest.chat_send_all("test")
				--move_head(player, on_water)
			--end

			-- Apply animations based on what the player is doing
			if playerz.is_dead(player) then
				player_set_animation(player, "lay")
			-- Determine if the player is walking
			elseif controls.up or controls.down or controls.left or controls.right then
				if player_sneak[name] ~= controls.sneak then
					player_anim[name] = nil
					player_sneak[name] = controls.sneak
				end
				if controls.LMB or controls.RMB then
					if not(on_water) then
						player_set_animation(player, "walk_mine", animation_speed_mod)
					else
						player_set_animation(player, "swin_and_mine", animation_speed_mod)
					end
				else
					if not(on_water) then
						player_set_animation(player, "walk", animation_speed_mod)
					else
						player_set_animation(player, "swin", animation_speed_mod)
					end
				end
			elseif controls.LMB or controls.RMB then
				if not(on_water) then
					player_set_animation(player, "mine", animation_speed_mod)
				else
					player_set_animation(player, "swin_mine", animation_speed_mod)
				end
			else
				if not(on_water) then
					player_set_animation(player, "stand", animation_speed_mod)
				else
					player_set_animation(player, "swin_stand", animation_speed_mod)
				end
			end
			if on_water and player_pos.y < 0 then
				if timer > 1 then
					player_pos.y = player_pos.y + 1
					minetest.add_particlespawner({
						amount = 6,
						time = 1,
						minpos = player_pos,
						maxpos = player_pos,
						minvel = {x=0, y=0, z=0},
						maxvel = {x=1, y=5, z=1},
						minacc = {x=0, y=0, z=0},
						maxacc = {x=1, y=1, z=1},
						minexptime = 0.2,
						maxexptime = 1.0,
						minsize = 1,
						maxsize = 1.5,
						collisiondetection = false,
						vertical = false,
						texture = "bubble.png",
					})
				end
			end
		else
			if playerz.get_status(player) == "sleep" then
				player_set_animation(player, "lay")
			elseif playerz.get_status(player) == "sit" then
				player_set_animation(player, "sit")
			end
		end
		if timer > 1 then
			playerz.hunger(player)
		end
	end
	if timer > 1 then
		timer = 0
	end
end)

function playerz.get_gender_formspec(name)
	local text = S("Select your gender")

	local formspec = {
		"formspec_version[3]",
		"size[3.2,2.476]",
		"label[0.375,0.5;", minetest.formspec_escape(text), "]",
		"image_button_exit[0.375,1;1,1;player_male_face.png;btn_male;"..S("Male").."]",
		"image_button_exit[1.7,1;1,1;player_female_face.png;btn_female;"..S("Female").."]"
	}

	-- table.concat is faster than string concatenation - `..`
	return table.concat(formspec, "")
end

function playerz.select_gender(player_name)
    minetest.show_formspec(player_name, "playerz:gender", playerz.get_gender_formspec(player_name))
end

function playerz.set_texture(player)
	local cloth = playerz.compose_cloth(player)
	local gender = playerz.get_gender(player)
	local gender_model = playerz.get_gender_model(gender)
	playerz.registered_models[gender_model].textures[1] = cloth
	playerz.update_model(player, gender_model, false)
	playerz.set_textures(player, models[gender_model].textures)
end

function playerz.get_face(base_texture, scale, escape)
	if not scale then
		scale = 1.0
	end
	local face = playerz.compose_face(base_texture, scale)
	if escape then
		face = minetest.formspec_escape(face)
	end
	return face
end

function playerz.compose_face(base_texture, scale)
	return playerz.compose_base_texture(base_texture, {
		canvas_size = "6x6",
		scale = scale,
		skin_texture = "player_face_skin.png",
		eyebrowns_pos = "0,0",
		eye_right_pos = "1,3",
		eye_left_pos = "4,3",
		mouth_pos = "0,5",
		hair_preview = true,
		hair_pos = "0,0",
	})
end

--Sleep functions

function playerz.count_sleeping()
	local count = 0
	for _, player in pairs(minetest.get_connected_players()) do
		if playerz.get_status(player) == "sleep" then
			count = count + 1
		end
	end
	return count
end

function playerz.is_sleeping(player)
	if playerz.get_status(player) == "sleep" then
		return true
	else
		return false
	end
end

function playerz.is_sit(player)
	if playerz.get_status(player) == "sit" then
		return true
	else
		return false
	end
end

--Level functions
function playerz.lvl_up(player)
	local meta = player:get_meta()
	local level = meta:get_int("level")
	meta:set_int("level", (level + 1))
end

function playerz.lvl_down(player)
	local meta = player:get_meta()
	local level = meta:get_int("level")
	if level == 0 then
		return
	end
	meta:set_int("level", (level - 1))
end

function playerz.set_lvl(player, level)
	if level <= 0 then
		return
	else
		player:get_meta():set_int("level", level)
	end
end

function playerz.reset_lvl(player, level)
	player:get_meta():set_int("level", 0)
end

--Player Register Functions

minetest.register_on_dieplayer(function(player, reason)
	playerz.set_status(player, "dead")
end)

minetest.register_on_respawnplayer(function(player)
	playerz.set_status(player, "normal")
	playerz.reset_hunger(player) --reinit hunger
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	player_anim[name] = nil
	player_textures[name] = nil
	player_sneak[name] = nil
	playerz.player_attached[name] = nil
	playerz.remove_hunger(player)
	playerz.count = playerz.count - 1
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "playerz:gender" then
		return
	end
	local gender
	if fields.btn_male or fields.btn_female then
		if fields.btn_male then
			gender = "male"
		else
			gender = "female"
		end
		playerz.set_gender(player, gender)
	else
		playerz.set_gender(player, "random")
	end
	playerz.set_base_textures(player) --set the default base_texture
	playerz.set_cloths(player) --set the default clothes
	playerz.set_texture(player)
end)

minetest.register_on_shutdown(function()
	for _, player in ipairs(minetest.get_connected_players()) do
		playerz.shutdown_hunger(player)
	end
end)
