throwz = {}

local S = minetest.get_translator(minetest.get_current_modname())

--CONSTANTS
local DEFAULT_MAX_HEAR_DISTANCE = 10
local DEFAULT_GAIN = 0.5

local function spawn_item_ent(item_ent, user, strength, wear)
	local player_hp = user:get_hp()
	local percent_hp = player_hp / 20
	strength = strength * percent_hp
	local dir = user:get_look_dir()
	local yaw = user:get_look_horizontal()
	local pos = user:get_pos()
	pos = vector.add(pos, vector.new(dir.x, 0, dir.z))
	pos.y = pos.y + 1.65 -- camera offset
	local obj = nil
	if pos and item_ent then
		obj = minetest.add_entity(pos, item_ent)
	end
	if not obj then
		return
	end
	local lua_ent = obj:get_luaentity()
	lua_ent.shooter_name = user:get_player_name()
	if wear then
		lua_ent.wear = wear
	end
	obj:set_yaw(yaw - 0.5 * math.pi)
	local velocity = vector.multiply(dir, strength)
	obj:set_velocity(velocity)
	return true
end

local function launch(item_ent, itemstack, user, name, def)
	local wear
	if def.type == "tool" then
		wear = itemstack:get_wear() + 0x10000 / def.throw_uses
	else
		wear = nil
	end
	--minetest.chat_send_all(tostring(wear))
	if not spawn_item_ent(item_ent, user, def.strength, wear) then --throw item (spawn item entity)
		return -- something failed
	end
	if def.throw_sounds then
		local user_pos = user:get_pos()
		if not def.throw_sounds.soundfile_throw then
			def.throw_sounds.soundfile_throw = "throwz_throw"
		end
		throwz.make_sound("pos", user_pos, def.throw_sounds.soundfile_throw, DEFAULT_GAIN, DEFAULT_MAX_HEAR_DISTANCE)
	end
end

function throwz.register_throw(name, def)
	assert(type(def.description) == "string")
	assert(type(def.inventory_image) == "string")
	assert(type(def.wield_image) == "string")
	assert(type(def.throw_damage) == "number")
	assert(type(def.strength) == "number")
	assert(type(def.recipe) == "table")

	local item_ent = name .. "_ent"

	local howto_use_msg
	if not def.primary_use then
		howto_use_msg = S("(use to throw)")
	else
		howto_use_msg = S("(right-click to throw)")
	end

	local description = def.description .. " " .. howto_use_msg

	if def.type == "tool" then

		assert(def.throw_uses > 0)
		assert(type(def.primary_use) == "table")

		def.primary_use.groups["throw"] = 1

		minetest.register_tool(name, {
			description = description,
			inventory_image = def.inventory_image,
			wield_image = def.wield_image or def.inventory_image,
			groups = def.primary_use.groups,
			tool_capabilities = def.primary_use.tool_capabilities,
			sound = def.primary_use.sound,

			on_use = function(itemstack, user, pointed_thing)
				if not def.primary_use then
					launch(item_ent, itemstack, user, name, def)
				else
					if pointed_thing.type == "object" then
						if pointed_thing.ref then
							pointed_thing.ref:punch(user, nil, def.primary_use.tool_capabilities, nil)
						end
					end
				end
				return itemstack
			end,

			on_secondary_use = function(itemstack, user, pointed_thing)
				if def.primary_use then
					launch(item_ent, itemstack, user, name, def)
				end
				itemstack:take_item()
				return itemstack
			end,

		})
	else
		minetest.register_craftitem(name, {
			description = description,
			inventory_image = def.inventory_image,
			wield_image = def.wield_image or def.inventory_image,
			groups = def.groups,

			on_use = function(itemstack, user, pointed_thing)
				launch(item_ent, itemstack, user, name, def)
				itemstack:take_item()
				return itemstack
			end,
		})
	end

	if def.recipe then
		minetest.register_craft({
			output = name,
			recipe = def.recipe
		})
	end

	minetest.register_entity(item_ent, {
		hp_max = 15,       -- possible to catch the throw (pro skills)
		physical = false, -- use Raycast
		collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
		visual = "wielditem",
		textures = {name},
		visual_size = {x = 0.2, y = 0.15},
		old_pos = nil,
		velocity = nil,
		liquidflag = nil,
		shooter_name = "",
		waiting_for_removal = false,
		static_save = true,
		groups = {throw = 1},

		on_activate = function(self)
			self.object:set_acceleration({x = 0, y = -9.81, z = 0})
		end,

		on_step = function(self, dtime)
			if self.waiting_for_removal then
				self.object:remove()
				return
			end
			local pos = self.object:get_pos()
			self.old_pos = self.old_pos or pos
			local velocity = self.object:get_velocity()
			if def.throw_sounds and not(def.throw_sounds.soundfile_hit) then
				def.throw_sounds.soundfile_hit = "throwz_hit"
			end
			local cast = minetest.raycast(self.old_pos, pos, true, true)
			local thing = cast:next()
			while thing do
				if thing.type == "object" and thing.ref ~= self.object then
					if not thing.ref:is_player() or thing.ref:get_player_name() ~= self.shooter_name then
						thing.ref:punch(self.object, 1.0, {
							full_punch_interval = 0.5,
							damage_groups = {fleshy = def.throw_damage or 1}
						})
						self.waiting_for_removal = true
						self.object:remove()

						if def.throw_sounds then
							local thing_pos = thing.ref:get_pos()
							if thing_pos then
								throwz.make_sound("pos", thing_pos, def.throw_sounds.soundfile_hit, DEFAULT_GAIN, DEFAULT_MAX_HEAR_DISTANCE)
							end
						end

						-- no effects or not owner, nothing to do.
						-- some effects should also happen if hitting an other object. like tnt, water etc.
						if not def.effects or minetest.is_protected(pos, self.shooter_name) then
							return
						end

						return
					end
				elseif thing.type == "node" then
					local node_name = minetest.get_node(thing.under).name
					local drawtype = minetest.registered_nodes[node_name]["drawtype"]
					if drawtype == 'liquid' then
						if not self.liquidflag then
							self.velocity = velocity
							self.liquidflag = true
							local liquidviscosity = minetest.registered_nodes[node_name]["liquid_viscosity"]
							local drag = 1/(liquidviscosity*6)
							self.object:set_velocity(vector.multiply(velocity, drag))
							self.object:set_acceleration({x = 0, y = -1.0, z = 0})
							throwz.splash(self.old_pos, "bubble.png")
						end
					elseif self.liquidflag then
						self.liquidflag = false
						if self.velocity then
							self.object:set_velocity(self.velocity)
						end
						self.object:set_acceleration({x = 0, y = -9.81, z = 0})
					end

					if minetest.registered_items[node_name].walkable then

						local drop_pos = self.old_pos

						if not(def.drop) and not(def.drop == "") then
							local drop_item = ItemStack(name)
							if self.wear then
								drop_item:set_wear(self.wear)
							end
							local item_ref =  minetest.add_item(drop_pos, drop_item)
							--minetest.item_drop(drop_item, nil, drop_pos)
							if item_ref and def.boom then
								minetest.after(def.boom.delay or 0, function()
									for _, obj in ipairs(minetest.get_objects_inside_radius(drop_pos, 1)) do
										if obj == item_ref then
											item_ref:remove()
											boomz.boom(drop_pos, def.boom.radius, def.boom.player_damage)
										end
									end
								end, drop_pos)
							end
						else
							minetest.set_node(drop_pos, {name = def.drop})
						end

						self.waiting_for_removal = true
						self.object:remove()

						if def.throw_sounds then
							if pos then
								throwz.make_sound("pos", pos, def.throw_sounds.soundfile_hit, DEFAULT_GAIN, DEFAULT_MAX_HEAR_DISTANCE)
							end
						end

						-- no effects or not owner, nothing to do.
						if not def.effects or minetest.is_protected(pos, self.shooter_name) then
							return
						end

						return
					end
				end
				thing = cast:next()
			end

			self.old_pos = pos

		end,
	})

end

--SOUND SYSTEM

function throwz.make_sound(dest_type, dest, soundfile, gain, max_hear_distance)
	if dest_type == "object" then
		minetest.sound_play(soundfile, {object = dest, gain = gain or DEFAULT_GAIN, max_hear_distance = max_hear_distance or DEFAULT_MAX_HEAR_DISTANCE,})
	 elseif dest_type == "player" then
		local player_name = dest:get_player_name()
		minetest.sound_play(soundfile, {to_player = player_name, gain = gain or DEFAULT_GAIN, max_hear_distance = max_hear_distance or DEFAULT_MAX_HEAR_DISTANCE,})
	 elseif dest_type == "pos" then
		minetest.sound_play(soundfile, {pos = dest, gain = gain or DEFAULT_GAIN, max_hear_distance = max_hear_distance or DEFAULT_MAX_HEAR_DISTANCE,})
	end
end

function throwz.splash(old_pos, splash_particle)
	minetest.add_particlespawner({
		amount = 5,
		time = 1,
		minpos = old_pos,
		maxpos = old_pos,
		minvel = {x=1, y=1, z=0},
		maxvel = {x=1, y=1, z=0},
		minacc = {x=1, y=1, z=1},
		maxacc = {x=1, y=1, z=1},
		minexptime = 0.2,
		maxexptime = 0.5,
		minsize = 1,
		maxsize = 1,
		collisiondetection = false,
		vertical = false,
		texture = splash_particle,
		playername = "singleplayer"
	})
end
