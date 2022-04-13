S, modname = ...

--
--Chair
--

local function check_chair(pos)
	local node = minetest.get_node_or_nil(pos)
	if (not node) or (minetest.get_node_group(node.name, "chair") == 0) then --not a chair
		return false
	else
		return true
	end
end

local function unmark_chair(pos)
	if check_chair(pos) then
		minetest.get_meta(pos):set_string("sit", "") --unmark the chair
	end
end

local function get_up(player)
	local meta = player:get_meta()
	local player_name = player:get_player_name()
	unmark_chair(minetest.string_to_pos(meta:get_string("deco:chair_pos")))
	playerphysics.remove_physics_factor(player, "speed", "chair")
	playerphysics.remove_physics_factor(player, "jump", "chair")
	playerphysics.remove_physics_factor(player, "gravity", "chair")
	playerz.set_status(player, "normal")
	player:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
	playerz.player_attached[player_name] = nil
end

local function get_out(player)
	if playerz.get_status(player) == "sit" then
		get_up(player)
		return true
	else
		return false
	end
end

local function sit_down(pos, player)
	local player_name = player:get_player_name()
	local meta_chair = minetest.get_meta(pos)

	meta_chair:set_string("sit", player_name) --mark the chair
	playerz.player_attached[player_name] = true
	-- physics, eye_offset, etc
	player:set_eye_offset({x = 0, y = -7, z = 0}, {x = 0, y = 0, z = 0})
	local yaw, param2 = helper.get_look_yaw(pos)
	player:set_look_horizontal(yaw)
	local dir = minetest.facedir_to_dir(param2)
	local player_pos = {
		x = pos.x + dir.x / 6,
		y = pos.y + 0.0625,
		z = pos.z + dir.z / 6
	}
	playerphysics.add_physics_factor(player, "speed", "chair", 0)
	playerphysics.add_physics_factor(player, "jump", "chair", 0)
	playerphysics.add_physics_factor(player, "gravity", "chair", 0)
	player:set_pos(player_pos)
	player:get_meta():set_string("deco:chair_pos", minetest.pos_to_string(pos))
	playerz.set_status(player, "sit")
	playerz.player_attached[player_name] = true
end

local function use_chair(pos, player)

	local player_name = player:get_player_name()

	if not(player:is_player()) then
		return false, ""
	end

	if vector.length(player:get_velocity()) > 0.0001 then
		return false, "You have to stop moving before sit down!"
	end

	--Check if already in chair or chair occupied
	local sit = minetest.get_meta(pos):get_string("sit")

	--Check if really chair occupied. This is a case of a crash when a player is on a chair (no unmarked chair)
	if not(sit == "") then
		local player_sit = minetest.get_player_by_name(sit)
		if not(player_sit) or not(playerz.get_status(player_sit) == "sit")
			or not(minetest.string_to_pos(player_sit:get_meta():get_string("deco:chair_pos")) == pos) then
				sit = ""
				unmark_chair(pos)
		end
	end

	if sit == player_name then
		get_up(player, nil)
		return true, ""
	elseif playerz.is_attached(player) then
		return false, "You are already attached to another thing"
	elseif not(sit == "") then
		return false, "This chair is already occupied"
	end

	--Sit down
	sit_down(pos, player)
	return true
end

function deco.register_chair(name, def)
	minetest.register_node(modname..":"..name, {
		description = S(def.description),
		tiles = def.tiles,
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = def.node_box,
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box,
		},
		sounds = sound.wood(),
		is_ground_content = false,
		stack_max = 4,
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, chair = 1},

		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local chair_used, msg = use_chair(pos, clicker)
			if not chair_used then
				local player_name = clicker:get_player_name()
				minetest.chat_send_player(player_name, S(msg))
			end
		end,

		on_destruct = function(pos)
			local meta = minetest.get_meta(pos)
			local sit = meta:get_string("sit")
			if not(sit == "") then
				local player = minetest.get_player_by_name(sit)
				if player then
					get_up(player, nil)
				end
			end
		end
	})
end

--Player Status

minetest.register_on_dieplayer(function(player, reason)
	get_out(player)
end)

minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
	return get_out(player)
end)

--
--Table
--

function deco.register_table(name, def)
	minetest.register_node(modname..":"..name, {
		description = S(def.description),
		tiles = def.tiles,
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = def.node_box
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box
		},
		sounds = sound.wood(),
		is_ground_content = false,
		stack_max = 1,
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, chair = 1},
	})
end
