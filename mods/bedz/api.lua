local modname = ...

local function get_look_yaw(pos)
	local rotation = minetest.get_node(pos).param2
	if rotation > 3 then
		rotation = rotation % 4 -- Mask colorfacedir values
	end
	if rotation == 1 then
		return math.pi / 2, rotation
	elseif rotation == 3 then
		return -math.pi / 2, rotation
	elseif rotation == 0 then
		return math.pi, rotation
	else
		return 0, rotation
	end
end

local function unmark_bed(pos)
	local node = minetest.get_node_or_nil(pos)
	if not node then
		return
	end
	if minetest.get_node_group(node.name, "bed") == 0 then --not a bed
		return
	end
	minetest.get_meta(pos):set_string("bedside", "") --unmark the bed
end

local function stop_sleep(player)
	local meta = player:get_meta()
	unmark_bed(minetest.string_to_pos(meta:get_string("bedz:bed_pos")))
	playerphysics.remove_physics_factor(player, "speed", "bedz")
	playerphysics.remove_physics_factor(player, "jump", "bedz")
	playerphysics.remove_physics_factor(player, "gravity", "bedz")
	playerz.set_status(player, "normal")
	player:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
end

minetest.register_on_dieplayer(function(player, reason)
	if playerz.get_status(player) == "sleep" then
		stop_sleep(player)
	end
end)

minetest.register_on_leaveplayer(function(player)
	if playerz.get_status(player) == "sleep" then
		stop_sleep(player)
	end
end)

local function awake(player)
	stop_sleep(player)
end

local function sleep(pos, player)
	local player_name = player:get_player_name()
	local meta_bed = minetest.get_meta(pos)

	meta_bed:set_string("bedside", player_name) --mark the bed

	-- physics, eye_offset, etc
	player:set_eye_offset({x = 0, y = -13, z = 0}, {x = 0, y = 0, z = 0})
	local yaw, param2 = get_look_yaw(pos)
	player:set_look_horizontal(yaw)
	local dir = minetest.facedir_to_dir(param2)
	local player_pos = {
		x = pos.x + dir.x / 3,
		y = pos.y + 0.07,
		z = pos.z + dir.z / 3
	}

	playerz.set_status(player, "sleep")
	playerphysics.add_physics_factor(player, "speed", "bedz", 0)
	playerphysics.add_physics_factor(player, "jump", "bedz", 0)
	playerphysics.add_physics_factor(player, "gravity", "bedz", 0)
	player:set_pos(player_pos)
	player:get_meta():set_string("bedz:bed_pos", minetest.pos_to_string(pos))
end

local function use_bed(pos, player)
	local player_name = player:get_player_name()

	-- Check if player is moving
	if vector.length(player:get_velocity()) > 0.001 then
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

	if bedside == player_name then
		return false, "You are already in bed"
	elseif not(bedside == "") then
		return false, "This bed is already occupied"
	end

	--Sleep
	sleep(pos, player)
	return true
end

--minetest.chat_send_all("test")

local function place_bed(bed_name, placer, pointed_thing)
	local above_pos = pointed_thing.above
	local placer_dir = vector.round(placer:get_look_dir())
	--minetest.chat_send_all("placer dir: "..minetest.pos_to_string(placer_dir))
	if (placer_dir.x == 0) and (placer_dir.z == 0) then
		return
	end
	local behind_pos = vector.offset(above_pos, placer_dir.x, 0.0, placer_dir.z)
	local node_behind = minetest.get_node_or_nil(behind_pos)
	if node_behind and helper.get_nodedef_field(node_behind.name, "drawtype") == "airlike" then
		local dir = minetest.dir_to_facedir(placer:get_look_dir()) or 0
		minetest.set_node(above_pos, {name = bed_name, param2 = dir})
	end
end

function bedz.register_bed(name, def)
	local bed_name = modname..":"..name
	minetest.register_node(bed_name, {
		description = def.description,
		inventory_image = def.inventory_image or "",
		wield_image = def.wield_image or def.inventory_image,
		drawtype = "nodebox",
		tiles = def.tiles,
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		stack_max = 1,
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, bed = 1},
		sounds = sound.wood(),
		node_box = {
			type = "fixed",
			fixed = def.nodebox,
		},
		selection_box = {
			type = "fixed",
			fixed = def.selectionbox,
		},
		on_place = function(itemstack, placer, pointed_thing)
			place_bed(bed_name, placer, pointed_thing)
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
					stop_sleep(player)
				end
			end
		end
	})
end
