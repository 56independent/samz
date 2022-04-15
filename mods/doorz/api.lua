S, modname = ...

minetest.register_node("doorz:invisible_top", {
	drawtype = "nodebox",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			 {0.4375, -0.5, 0, 0.5, -0.5, 0.0625},
		},
	},
	tiles = {"blank.png"},
	use_texture_alpha = "clip",
	is_ground_content = false,
	groups = {not_in_creative_inventory = 1},
})

local function destroy_inv_top(pos)
	local above_pos = vector.new(pos.x, pos.y+1, pos.z)
	minetest.set_node(above_pos, {name = "air"})
end

local function is_doorz_on_right(pos, doorz_dir)
	local up_vector = vector.new(0, 1, 0) --vertical y vector
	local right_vector = vector.cross(up_vector, doorz_dir)
	--local left_vector = - right_vector
	local right_pos = vector.add(pos, right_vector)
	if helper.in_group(right_pos, "door") then
		return true
	else
		return false
	end
end

local function place_door(doorz_name, placer, pointed_thing)
	local pos = pointed_thing.above
	local doorz_dir = helper.dir_to_compass(placer:get_look_dir())
	--minetest.chat_send_all(tostring(doorz_dir))
	if helper.node_is_air(pos) then
		local above_pos = vector.new(pos.x, pos.y+1, pos.z)
		if helper.node_is_air(above_pos) then
			local dir = placer:get_look_dir()
			local rotation
			if is_doorz_on_right(pos, doorz_dir) then
				dir = -dir
				rotation = "left"
			else
				rotation = "right"
			end
			local facedir = minetest.dir_to_facedir(dir) or 0
			minetest.set_node(pos, {name = doorz_name, param2 = facedir})
			minetest.set_node(above_pos, {name = "doorz:invisible_top", param2 = facedir})
			local meta = minetest.get_meta(pos)
			meta:set_string("doorz:dir", vector.to_string(doorz_dir))
			meta:set_string("doorz:rotation", rotation)
			return true
		else
			return false
		end
	else
		return false
	end
end

local function open_door(pos, node, clicker, doorz_name)
	local meta = minetest.get_meta(pos)
	local open_dir_str = meta:get_string("doorz:dir")
	local open_dir = minetest.string_to_pos(open_dir_str)
	if not open_dir then
		open_dir = vector.round(clicker:get_look_dir())
	end
	local node_open_pos = vector.add(pos, open_dir)
	local node_open = minetest.get_node_or_nil(node_open_pos)
	if node_open and (
		helper.get_nodedef_field(node_open.name, "buildable_to") or
		helper.node_is_air(node_open_pos)
		) then
			if helper.node_is_air(node_open_pos, "above") then
				local facedir = minetest.dir_to_facedir(open_dir)
				local doorz_name_opened = doorz_name.."_opened"
				local rotation = meta:get_string("doorz:rotation")
				if rotation == "left" then
					doorz_name_opened = doorz_name_opened.."_left"
				end
				minetest.set_node(pos, {name = doorz_name_opened, param2 = facedir})
				sound.play("pos", pos, "doorz_open")
				local above_pos = vector.new(pos.x, pos.y+1, pos.z)
				minetest.set_node(above_pos, {name = "doorz:invisible_top", param2 = facedir})
				meta = minetest.get_meta(pos)
				meta:set_int("doorz:facedir", node.param2)
				meta:set_string("doorz:dir", open_dir_str)
				meta:set_string("doorz:rotation", rotation)
				return true
			else
				return false
			end
	else
		return false
	end
end

local function close_door(pos, doorz_name)
	local meta = minetest.get_meta(pos)
	local facedir = meta:get_int("doorz:facedir")
	local dir = meta:get_string("doorz:dir")
	local rotation = meta:get_string("doorz:rotation")
	minetest.set_node(pos, {name = doorz_name, param2 = facedir})
	sound.play("pos", pos, "doorz_close")
	local above_pos = vector.new(pos.x, pos.y+1, pos.z)
	minetest.set_node(above_pos, {name = "doorz:invisible_top", param2 = facedir})
	meta = minetest.get_meta(pos)
	meta:set_string("doorz:dir", dir)
	meta:set_string("doorz:rotation", rotation)
end

function doorz.register_door(name, def)

	local doorz_name = modname..":"..name

	minetest.register_node(doorz_name, {
		description = S("@1 Door", S(def.description)),
		inventory_image = def.inventory_image or "",
		wield_image = def.wield_image or def.inventory_image or "",
		drawtype = "mesh",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "facedir",
		mesh = "doorz.b3d",
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.0625, 0.5, 1.5, 0.0625},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				 {-0.5, -0.5, -0.0625, 0.5, 1.5, 0.0625},
			},
		},
		tiles = def.tiles,
		use_texture_alpha = "clip",
		is_ground_content = false,
		groups = {choppy = 2, door = 1},
		stack_max = 1,
		buildable_to = false,
		sounds = sound.wood(),

		on_place = function(itemstack, placer, pointed_thing)
			if place_door(doorz_name, placer, pointed_thing) then
				itemstack:take_item()
			end
			return itemstack
		end,

		on_destruct = function(pos)
			destroy_inv_top(pos)
		end,

		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			if not open_door(pos, node, clicker, doorz_name) then
				if clicker and minetest.is_player(clicker) then
					local player_name = clicker:get_player_name()
					sound.play("pos", pos, "doorz_blocked")
					minetest.chat_send_player(player_name, S("Obstructed door!"))
				end
			end
		end,
	})

	for i=0,1 do
		local mesh, fixed, doorz_name_opened
		if i == 0 then
			mesh = "doorz_opened.b3d"
			fixed = {0.375, -0.5, 0, 0.5, 1.5, 1.0}
			doorz_name_opened = doorz_name.."_opened"
		else
			mesh = "doorz_opened_left.b3d"
			fixed = {-0.5, -0.5, 0, -0.375, 1.5, 1.0}
			doorz_name_opened = doorz_name.."_opened_left"
		end

		minetest.register_node(doorz_name_opened, {
			description = def.description,
			drawtype = "mesh",
			paramtype = "light",
			paramtype2 = "facedir",
			mesh = mesh,
			selection_box = {
				type = "fixed",
				fixed = {
					fixed,
				},
			},
			collision_box = {
				type = "fixed",
				fixed = {
					fixed,
				},
			},
			drop = doorz_name,
			tiles = def.tiles,
			walkable = true,
			use_texture_alpha = "clip",
			is_ground_content = false,
			groups = {choppy = 2, door = 1, not_in_creative_inventory = 1},
			stack_max = 1,
			buildable_to = false,
			sounds = sound.wood(),

			on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
				close_door(pos, doorz_name)
			end,

			on_destruct = function(pos)
				destroy_inv_top(pos)
			end

		})
	end

	if def.recipe then
		minetest.register_craft({
			output = doorz_name,
			type = "shaped",
			recipe = def.recipe
		})
	end
end
