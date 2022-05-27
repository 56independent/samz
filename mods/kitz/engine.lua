S, modname = ...

--Consts

local gravity = -9.8

--The mob register

kitz.active_mobs = {}
local _id = 0

function kitz.logon_mob(self)
	_id = _id + 1
	kitz.active_mobs[_id] = self
	self._id = _id
end

function kitz.logout_mob(self)
	kitz.active_mobs[self._id] = nil
end

local pos_to_spawn = function(name, pos)
	local x = pos.x
	local y = pos.y
	local z = pos.z
	if minetest.registered_entities[name] and minetest.registered_entities[name].visual_size.x then
		if minetest.registered_entities[name].visual_size.x >= 32 and
			minetest.registered_entities[name].visual_size.x <= 48 then
				y = y + 2
		elseif minetest.registered_entities[name].visual_size.x > 48 then
			y = y + 5
		else
			y = y + 1
		end
	end
	local spawn_pos = {x = x, y = y, z = z}
	return spawn_pos
end

kitz.create_mob = function(placer, itemstack, name, pos)
	local meta = itemstack:get_meta()
	local staticdata = meta:get_string("staticdata")
	local mob = minetest.add_entity(pos, name, staticdata)
	local obj_ref = mob:get_luaentity()
	if not(obj_ref.tamed) then --not owner
		obj_ref:set_owner(placer) --set owner
	end
	itemstack:take_item() -- since mob is unique we remove egg once spawned
	return obj_ref
end

function kitz.register_egg(name, def)

	local description = S("@1", def.desc)

	if def.tamed then
		description = description .." ("..S("Tamed")..")"
	end

	minetest.register_craftitem(name .. "_egg", { -- register new spawn egg containing mob information
		description = description,
		inventory_image = def.egg_inv_img,
		groups = {spawn_egg = 1},
		stack_max = 1,
		on_place = function(itemstack, placer, pointed_thing)
			local spawn_pos = pointed_thing.above
			local under = minetest.get_node(pointed_thing.under)
			local node_under = minetest.registered_nodes[under.name]
			if node_under and node_under.on_rightclick then
				return node_under.on_rightclick(pointed_thing.under, under, placer, itemstack)
			end
			if spawn_pos and not minetest.is_protected(spawn_pos, placer:get_player_name()) then
				if not minetest.registered_entities[name] then
					return
				end
				spawn_pos = pos_to_spawn(name, spawn_pos)
				kitz.create_mob(placer, itemstack, name, spawn_pos)
			end
			return itemstack
		end,
	})
end

function kitz.on_step_timer(self, seconds) -- returns true approx every s seconds
	local t1 = math.floor(self.active_time)
	local t2 = math.floor(self.active_time + self.dtime)
	if t2 > t1 and t2 % seconds == 0 then
		return true
	end
end

function kitz.register_mob(name, def)
	local _name = modname..":"..name
	local __name = modname.."_"..name
	minetest.register_entity(_name, {
        initial_properties = def.initial_properties,
        physical = true,
		stepheight = 0.1,
		collide_with_objects = true,
		visual = "mesh",
		mesh = __name..".b3d",
		textures = {},
		visual_size = {
			x = 10 * def.scale,
			y = 10 * def.scale,
			z = 10 * def.scale
		},
		collisionbox = {
			def.collisionbox.xmin* def.scale,
			def.collisionbox.ymin* def.scale,
			def.collisionbox.zmin* def.scale,
			def.collisionbox.xmax* def.scale,
			def.collisionbox.ymax* def.scale,
			def.collisionbox.zmax* def.scale,
		},
		static_save = true,

        on_activate = function(self, staticdata, dtime_s)
			kitz.activate(self)
        end,

		on_deactivate = function(self)
			kitz.deactivate(self)
		end,

        on_step = function(self, dtime, moveresult)
			kitz.step(self, dtime)
		end,

        on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
        end,

        on_rightclick = function(self, clicker)
        end,

        get_staticdata = function(self)
        -- Called sometimes; the string returned is passed to on_activate when
        -- the entity is re-activated from static state
        end,

		vars = { --memory
			name = _name,
			status = nil,
			tamed = false,
			lifetime = 0,
			textures = def.textures or {},
			texture_no = 1,
			type = name,
			view_range = def.view_range or 5,
		},

		clear_path = function(self)
			if not self.path then
				return false
			else
				self.path = nil
				return true
			end
		end,

		create_path = function(self)
			self.path = {}
			return self.path
		end,

		get_name  = function(self)
			return self.get_var("name")
		end,

		get_owner = function(self)
			return self:get_var("owner")
		end,

		get_path = function(self)
			return self.path
		end,

		get_status = function(self)
			return self:get_var("status")
		end,

		get_texture = function(self)
			return __name.."_"..self:get_var("textures")[self:get_var("texture_no")]..".png"
		end,

		get_var = function(self, var)
			return self.vars[var]
		end,

		remove_owner = function(self)
			self:set_var("tamed", nil)
		end,

		roam = function(self, pos, vel, dtime)
			return kitz.roam(self, pos, vel, dtime)
		end,

		set_owner = function(self, owner)
			self:set_var("tamed", owner:get_player_name())
		end,

		set_status = function(self, status)
			return self:set_var("status", status)
		end,

		set_var = function(self, var, value)
			self.vars[var] = value
			return value
		end,

		stop = function(self)
			self:clear_path()
			self.object:set_velocity(vector.new(0, 0, 0))
		end,
    })
    kitz.register_egg(_name, {desc = def.desc, egg_inv_img = def.egg_inv_img, tamed = true})
end


function kitz.init(self, staticdata, dtime_s)
	local textures = self.get_var("textures")
	if #textures > 1 then
		self:set_var("texture_no", random(#textures))
	end
end

function kitz.activate(self, staticdata, dtime_s)
	if dtime_s == 0 then --very first time created
		kitz.init(self, staticdata, dtime_s)
	end
	self.active_time = 0
	--Apply properties
	self.object:set_properties{
		textures = {self:get_texture()}
	}
	minetest.chat_send_all(self:get_texture())
	kitz.logon_mob(self)
end

function kitz.deactivate(self)
	kitz.logout_mob(self)
end

function kitz.distance_2d(p1, p2)
	return math.sqrt((p2.x-p1.x)^2 + (p2.y-p1.y)^2)
end

function kitz.is_near_2d(p1, p2, threshold)
	if math.abs(p2.x-p1.x) < threshold and math.abs(p2.z-p1.z) < threshold then
		return true
	else
		return false
	end
end

function kitz.roam(self, pos, vel, dtime)
	if self.path then
		local dist = kitz.distance_2d(pos, self.path[1])
		if kitz.is_near_2d(pos, self.path[1], 0.0625) or
			dist > self.distance_2d then
				self:stop()
				return false
		else
			self.distance_2d = dist
		end
	else
		local new_pos = vector.new(
			pos.x + math.random(-1, 1),
			pos.y,
			pos.z + math.random(-1, 1)
		)
		if helper.node_is_air(new_pos, -1) then
			local dir = vector.subtract(new_pos, pos)
			local frame = 0.07
			vel = {
				x = math.round(dir.x * (1 - math.sin(frame*0.7, 1)), 4),
				y = vel.y,
				z = math.round(dir.z * (1 - math.sin(frame*0.7, 1)), 4)
			}
			self:create_path()
			self.distance_2d = kitz.distance_2d(pos, new_pos)
			self.path[#self.path+1] = new_pos
			minetest.chat_send_all("no")
		else
			self:set_status("jump")
			minetest.chat_send_all("jump")
		end
	end
	return vel
end

local function is_inside_range(p1, p2, pos)
	if (p1.x <= pos.x) and (pos.x <= p2.x)
			and (p1.y <= pos.y) and (pos.y <= p2.y)
				and (p1.z <= pos.z) and (pos.z <= p2.z) then
					return true
	else
		return false
	end
end

local function sensors(self)
	local pos = self.object:get_pos()
	local view_range = self.vars.view_range
	local p1 = {
		x = pos.x - view_range,
		y = pos.y - view_range,
		z = pos.z - view_range,
	}
	local p2 = {
		x = pos.x + view_range,
		y = pos.y + view_range,
		z = pos.z + view_range,
	}
	local nearby_mobs = {}
	for key, value in pairs(kitz.active_mobs) do
		local mob_pos = value.object:get_pos()
		if is_inside_range(p1, p2, mob_pos) then
			nearby_mobs[#nearby_mobs+1] = key
		end
	end
	local nearby_players = {}
	for _, player in pairs(minetest.get_connected_players()) do
		local player_pos = player:get_pos()
		if is_inside_range(p1, p2, player_pos) then
			nearby_players[#nearby_players+1] = player:get_player_name()
		end
	end
	return nearby_mobs, nearby_players
end

local impulse = 5

function kitz.step(self, dtime)
	self.dtime = math.min(dtime, 0.1)
	local pos = self.object:get_pos()
	local vel = self.object:get_velocity()
	local new_vel

	if kitz.on_step_timer(self, 1) then
		sensors(self)
	end

	local status = self:get_status()
	if not(status) then
		status = self:set_status("roam")
	end
	if status == "roam" then
		new_vel = self:roam(pos, vel, dtime)
		--minetest.chat_send_all(tostring(new_vel))
	elseif status == "jump" then
		--status = self:set_status("roam")
		minetest.chat_send_all("jump")
	elseif status == "stand" then

	end
	if new_vel then
		self.object:set_velocity(new_vel)
		self.object:set_yaw(minetest.dir_to_yaw(new_vel))
	else
		self.object:set_velocity(vel)
	end
	if status == "roam" then
		self.object:set_acceleration({x=0, y= gravity, z=0})
	elseif status == "jump" then
		self.object:set_velocity({x=2, y= 4, z=2})
		self.object:set_acceleration({x=1, y= 3, z=1})
		minetest.after(0.3, function(self)
			status = self:set_status("stand")
			self:stop()
		end, self)
	elseif status == "stand" then
		self.object:set_acceleration({x=0, y= gravity, z=0})
	end
	--minetest.chat_send_all(tostring(new_vel) or "")
	self.vars.lifetime = self.vars.lifetime + dtime
	self.active_time = self.active_time + dtime
end
