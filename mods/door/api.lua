S, modname = ...

minetest.register_node("door:invisible_top", {
	drawtype = "nodebox",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			 {0.4375, -0.5, 0, 0.5, -0.5, 0.0625},
		},
	},
	tiles = {"blank.png"},
	use_texture_alpha = true,
	is_ground_content = false,
	groups = {not_in_creative_inventory = 1},
})

local function destroy_inv_top(pos)
	local above_pos = vector.new(pos.x, pos.y+1, pos.z)
	minetest.set_node(above_pos, {name = "air"})
end

local function is_door_on_right(pos, door_dir)
	local up_vector = vector.new(0, 1, 0)
	local right_vector = vector.cross(up_vector, door_dir)
	--local left_vector = - right_vector
	local right_pos = vector.add(pos, right_vector)
	if helper.in_group(right_pos, "door") then
		return true
	else
		return false
	end
end

local function place_door(door_name, placer, pointed_thing)
	local pos = pointed_thing.above
	local door_dir = helper.dir_to_compass(placer:get_look_dir())
	--minetest.chat_send_all(tostring(door_dir))
	if helper.node_is_air(pos) then
		local above_pos = vector.new(pos.x, pos.y+1, pos.z)
		if helper.node_is_air(above_pos) then
			local dir = placer:get_look_dir()
			local rotation
			if is_door_on_right(pos, door_dir) then
				dir = -dir
				rotation = "left"
			else
				rotation = "right"
			end
			local facedir = minetest.dir_to_facedir(dir) or 0
			minetest.set_node(pos, {name = door_name, param2 = facedir})
			minetest.set_node(above_pos, {name = "door:invisible_top", param2 = facedir})
			local meta = minetest.get_meta(pos)
			meta:set_string("door:dir", vector.to_string(door_dir))
			meta:set_string("door:rotation", rotation)
			return true
		else
			return false
		end
	else
		return false
	end
end

local function open_door(pos, node, clicker, door_name)
	local meta = minetest.get_meta(pos)
	local open_dir_str = meta:get_string("door:dir")
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
				local door_name_opened = door_name.."_opened"
				local rotation = meta:get_string("door:rotation")
				if rotation == "left" then
					door_name_opened = door_name_opened.."_left"
				end
				minetest.set_node(pos, {name = door_name_opened, param2 = facedir})
				sound.play("pos", pos, "door_open")
				local above_pos = vector.new(pos.x, pos.y+1, pos.z)
				minetest.set_node(above_pos, {name = "door:invisible_top", param2 = facedir})
				meta = minetest.get_meta(pos)
				meta:set_int("door:facedir", node.param2)
				meta:set_string("door:dir", open_dir_str)
				meta:set_string("door:rotation", rotation)
			end
	end
end

local function close_door(pos, door_name)
	local meta = minetest.get_meta(pos)
	local facedir = meta:get_int("door:facedir")
	local dir = meta:get_string("door:dir")
	local rotation = meta:get_string("door:rotation")
	minetest.set_node(pos, {name = door_name, param2 = facedir})
	sound.play("pos", pos, "door_close")
	local above_pos = vector.new(pos.x, pos.y+1, pos.z)
	minetest.set_node(above_pos, {name = "door:invisible_top", param2 = facedir})
	meta = minetest.get_meta(pos)
	meta:set_string("door:dir", dir)
	meta:set_string("door:rotation", rotation)
end

function door.register_door(name, def)

	local door_name = modname..":"..name

	minetest.register_node(door_name, {
		description = S("@1 Door", S(def.description)),
		inventory_image = def.inventory_image or "",
		wield_image = def.wield_image or def.inventory_image or "",
		drawtype = "mesh",
		paramtype = "light",
		paramtype2 = "facedir",
		mesh = "door.b3d",
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
		use_texture_alpha = true,
		is_ground_content = false,
		groups = {choppy = 2, door = 1},
		stack_max = 1,
		buildable_to = false,
		sounds = sound.wood(),

		on_place = function(itemstack, placer, pointed_thing)
			if place_door(door_name, placer, pointed_thing) then
				itemstack:take_item()
			end
			return itemstack
		end,

		on_destruct = function(pos)
			destroy_inv_top(pos)
		end,

		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			open_door(pos, node, clicker, door_name)
		end,
	})

	for i=0,1 do
		local mesh, fixed, door_name_opened
		if i == 0 then
			mesh = "door_opened.b3d"
			fixed = {0.375, -0.5, 0, 0.5, 1.5, 1.0}
			door_name_opened = door_name.."_opened"
		else
			mesh = "door_opened_left.b3d"
			fixed = {-0.5, -0.5, 0, -0.375, 1.5, 1.0}
			door_name_opened = door_name.."_opened_left"
		end

		minetest.register_node(door_name_opened, {
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
			drop = door_name,
			tiles = def.tiles,
			walkable = true,
			use_texture_alpha = true,
			is_ground_content = false,
			groups = {choppy = 2, door = 1, not_in_creative_inventory = 1},
			stack_max = 1,
			buildable_to = false,
			sounds = sound.wood(),

			on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
				close_door(pos, door_name)
			end,

			on_destruct = function(pos)
				destroy_inv_top(pos)
			end

		})
	end
end
