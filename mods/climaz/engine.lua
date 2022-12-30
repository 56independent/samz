local modpath = ...
climaz = {}
climaz.wind = {}
climaz.climates = {}
climaz.settings = {}

--Settings

local settings = Settings(modpath .. "/climaz.conf")

climaz.settings = {
	climate_min_height = tonumber(settings:get("climate_min_height")),
	climate_max_height = tonumber(minetest.settings:get('climate_max_height', true)) or 120,
	climate_change_ratio = tonumber(settings:get("climate_change_ratio")),
	radius = tonumber(settings:get("climate_radius")),
	climate_duration = tonumber(settings:get("climate_duration")),
	duration_random_ratio = tonumber(settings:get("climate_duration_random_ratio")),
	climate_rain_sound = settings:get_bool("climate_rain_sound"),
	thunder_sound = settings:get_bool("thunder_sound"),
	storm_chance = tonumber(settings:get("storm_chance")),
	lightning = settings:get_bool("lightning"),
	lightning_chance = tonumber(settings:get("lightning_chance")),
	dust_effect = settings:get_bool("dust_effect"),
	rain_particles = tonumber(settings:get("rain_particles")) or 15,
	rain_falling_speed = tonumber(settings:get("rain_falling_speed")) or 15,
	lightning_duration = tonumber(settings:get("lightning_duration")) or 0.15,
	rain_sound_gain = tonumber(settings:get("rain_sound_gain")) or 0.35,
}

local timer = 0 -- A timer to create climates each x seconds an for lightning too.

--Helper Functions

local function remove_table_by_key(tab, key)
	local i = 0
	local keys, values = {},{}
	for k, v in pairs(tab) do
		i = i + 1
		keys[i] = k
		values[i] = v
	end

	while i > 0 do
		if keys[i] == key then
			table.remove(keys, i)
			table.remove(values, i)
			break
		end
		i = i - 1
	end

	local new_tab = {}

	for j = 1, #keys do
		new_tab[keys[j]] = values[j]
	end

	return new_tab
end

function climaz.is_inside_climate(pos)
	--check if underwater
	local underwater
	pos.y = pos.y + 1
	local node_name = minetest.get_node(pos).name
	if minetest.registered_nodes[node_name] and (
		minetest.registered_nodes[node_name]["liquidtype"] == "source" or
		minetest.registered_nodes[node_name]["liquidtype"] == "flowing") then
			underwater = true
	end
	pos.y = pos.y - 1
	--This function returns the climate_id if inside
	--check altitude
	if (pos.y < climaz.settings.climate_min_height) or (pos.y > climaz.settings.climate_max_height) then
		return false, underwater
	end
	--If sphere's centre coordinates is (cx,cy,cz) and its radius is r,
	--then point (x,y,z) is in the sphere if (x−cx)2+(y−cy)2+(z−cz)2<r2.
	for i, _climate in ipairs(climaz.climates) do
		local climate_center = climaz.climates[i].center
		if climaz.settings.radius > math.sqrt((pos.x - climate_center.x)^2 +
			(pos.y - climate_center.y)^2 +
			(pos.z - climate_center.z)^2
			) then
				return i, underwater
		end
	end
	return false, underwater
end

local function has_light(minp, maxp)
	local manip = minetest.get_voxel_manip()
	local e1, e2 = manip:read_from_map(minp, maxp)
	local area = VoxelArea:new{MinEdge=e1, MaxEdge=e2}
	local data = manip:get_light_data()
	local node_num = 0
	local light = false

	for i in area:iterp(minp, maxp) do
		node_num = node_num + 1
		if node_num < 5 then
			if data[i] and data[i] == 15 then
				light = true
				break
			end
		else
			node_num = 0
		end
	end

	return light
end

local function is_on_surface(player_pos)
	local height = minetest.get_spawn_level(player_pos.x, player_pos.z)
	--minetest.chat_send_all(tostring(height))
	if not height then
		return false
	end
	if (player_pos.y + 5) >= height then
		return true
	end
end

--DOWNFALLS REGISTRATIONS

climaz.registered_downfalls = {}

local function register_downfall(name, def)
	local new_def = table.copy(def)
	climaz.registered_downfalls[name] = new_def
end

register_downfall("rain", {
	min_pos = {x = -15, y = 10, z = -15},
	max_pos = {x = 15, y = 10, z = 15},
	falling_speed = climaz.settings.rain_falling_speed,
	amount = climaz.settings.rain_particles,
	exptime = 1,
	size = 1.75,
	texture = {"climaz_rain.png", "climaz_rain2.png", "climaz_rain3.png"},
})

register_downfall("storm", {
	min_pos = {x = -15, y = 20, z = -15},
	max_pos = {x = 15, y = 20, z = 15},
	falling_speed = 20,
	amount = 20,
	exptime = 1,
	size = 1.5,
	texture = {"climaz_rain.png", "climaz_rain2.png", "climaz_rain3.png"},
})

register_downfall("snow", {
	min_pos = {x = -15, y = 10, z= -15},
	max_pos = {x = 15, y = 10, z = 15},
	falling_speed = 5,
	amount = 10,
	exptime = 5,
	size = 1,
	texture= {"climaz_snow.png", "climaz_snow2.png", "climaz_snow3.png"},
})

register_downfall("sand", {
	min_pos = {x = -20, y = -4, z = -20},
	max_pos = {x = 20, y = 4, z = 20},
	falling_speed = -1,
	amount = 25,
	exptime = 1,
	size = 4,
	texture = "climaz_sand.png",
})

--WIND STUFF

local function create_wind()
	local wind = {
		x = math.random(0,5),
		y = 0,
		z = math.random(0,5)
	}
	return wind
end

function climaz.get_player_wind(player_name)
	local player = minetest.get_player_by_name(player_name)
	if not player then
		return
	end
	local player_pos = player:get_pos()
	local climate_id = climaz.is_inside_climate(player_pos)
	if climate_id then
		return climaz.climates[climate_id].wind
	else
		return create_wind()
	end
end

--LIGHTING

local function show_lightning(player_name)
	local player = minetest.get_player_by_name(player_name)
	if not player then
		return
	end
	local hud_id = player:hud_add({
		hud_elem_type = "image",
		text = "climaz_lightning.png",
		position = {x=0, y=0},
		scale = {x=-100, y=-100},
		alignment = {x=1, y=1},
		offset = {x=0, y=0}
	})
	--save the lightning per player, NOT per climate
	player:get_meta():set_int("climaz:lightning", hud_id)
	if climaz.settings.thunder_sound then
		minetest.sound_play("climaz_thunder", {
			to_player = player_name,
			loop = false,
			gain = 1.0,
		})
	end
end

local function remove_lightning(player_name)
	local player = minetest.get_player_by_name(player_name)
	if not player then
		return
	end
	local meta = player:get_meta()
	local hud_id = meta:get_int("climaz:lightning")
	player:hud_remove(hud_id)
	meta:set_int("climaz:lightning", -1)
end

-- CLIMATE PLAYERS FUNCTIONS

local function get_player_climate_id(player)
	local id = player:get_meta():get_int("climaz:climate_id")
	if id == 0 then
		id = nil
	end
	return id
end

local function set_player_climate_id(player_name, value)
	local player = minetest.get_player_by_name(player_name)
	if player then
		player:get_meta():set_int("climaz:climate_id", value)
	end
end

local function reset_player_climate_id(player_name)
	local player = minetest.get_player_by_name(player_name)
	if player then
		player:get_meta():set_int("climaz:climate_id", 0)
	end
end

--CLIMATE FUNCTIONS

local function get_id()
	local id
	--search for a free position
	for i= 1, (#climaz.climates+1) do
		if not climaz.climates[i] then
			id = i
			break
		end
	end
	return id
end

local climate = {
	id = nil,
	center = {},
	players = {},
	downfall_type = "",
	wind = {},
	timer = 0,
	end_time = 0,

	new = function(self, climate_id, player_name, underwater)

		local new_climate = {}

		setmetatable(new_climate, self)

		self.__index = self

		--Get the climate_id
		new_climate.id = climate_id

		--program climate's end
		local climate_duration = climaz.settings.climate_duration
		local climate_duration_random_ratio = climaz.settings.duration_random_ratio
		--minetest.chat_send_all(tostring(climate_id))
		new_climate.end_time = (math.random(climate_duration - (climate_duration*climate_duration_random_ratio),
			climate_duration + (climate_duration*climate_duration_random_ratio)))

		--Get the center of the climate
		local player = minetest.get_player_by_name(player_name)
		new_climate.center = player:get_pos()

		--Get the downfall type

		--Firstly get some biome data
		local biome_data = minetest.get_biome_data(new_climate.center)
		local biome_heat = biome_data.heat
		local biome_humidity = biome_data.humidity

		local downfall_type

		--Firstly check high

		if minetest.get_player_by_name(player_name):get_pos().y >= mapgenz.biomes.peaky_mountain_height then
			downfall_type = "snow"
		else
			if biome_heat > 28 and biome_humidity >= 35 then
				local chance = math.random(climaz.settings.storm_chance)
				if chance == 1 then
					downfall_type = "storm"
				else
					downfall_type = "rain"
				end
			elseif biome_heat >= 50 and biome_humidity <= 20  then
				downfall_type = "sand"
			elseif biome_heat <= 28 then
				downfall_type = "snow"
			end
		end

		if not downfall_type then --fallback
			downfall_type = "rain"
		end

		new_climate.downfall_type = downfall_type

		--minetest.chat_send_all("id= "..minetest.get_biome_name(biome_data.biome)..", heat="..tostring(biome_heat).. ", downfall type: "..downfall_type)

		--Get the wind of the climate
		--Create wind
		local wind = create_wind()

		--strong wind if a storm
		if downfall_type == "storm" then
			wind = {
				x = wind.x * 2,
				y = wind.y,
				z = wind.z * 2,
			}
		end

		--very strong wind if a sandstorm
		if downfall_type == "sand" then
			if wind.x < 1 then
				wind.x = 1
				wind.y = 1
			end
			wind = {
				x = wind.x * 5,
				y = wind.y,
				z = wind.z * 5,
			}
		end

		new_climate.wind = wind

		--save the player
		self:add_player(player_name, new_climate.id, new_climate.downfall_type, underwater)

		return new_climate

	end,

	on_timer = function(self)
		--minetest.chat_send_all(tostring(self.timer))
		if self.timer >= self.end_time then
			self:remove() --remove the climate
			self.timer = 0
		end
	end,

	remove_players = function(self)
		for _player_name, _climate in pairs(self.players) do
			self:remove_player(_player_name)
			--minetest.chat_send_all(_player_name.." removed from climate")
		end
	end,

	remove = function(self)
		--remove the players
		self:remove_players(self.id)
		--remove the climate
		climaz.climates = remove_table_by_key(climaz.climates, self.id)
	end,

	stop = function(self)
		--remove the players
		self:remove_players(self.id)
		--remove the climate
		climaz.climates = remove_table_by_key(climaz.climates, self.id)
	end,

	apply = function(self, _player_name)

		if self.players[_player_name].underwater then
			return
		end

		local _player = minetest.get_player_by_name(_player_name)

		local _player_pos = _player:get_pos()
		local _player_vel = _player:get_player_velocity()

		local downfall = climaz.registered_downfalls[self.downfall_type]
		local wind_pos = vector.multiply(self.wind, -1)
		local minp = vector.add(vector.add(vector.add(_player_pos, _player_vel), downfall.min_pos), wind_pos)
		local maxp = vector.add(vector.add(vector.add(_player_pos, _player_vel), downfall.max_pos), wind_pos)

		--Check if in player in interiors or not
		if not has_light(minp, maxp) then
			return
		end

		local vel = {x = self.wind.x, y = - downfall.falling_speed, z = self.wind.z}
		local acc = {x = 0, y = 0, z = 0}
		local exp = downfall.exptime

		local downfall_texture
		if type(downfall.texture) == "table" then
			downfall_texture = downfall.texture[math.random(#downfall.texture)]
		else
			downfall_texture = downfall.texture
		end

		minetest.add_particlespawner({
			amount = downfall.amount, time=0.5,
			minpos = minp, maxpos = maxp,
			minvel = vel, maxvel = vel,
			minacc = acc, maxacc = acc,
			minexptime = exp, maxexptime = exp,
			minsize = downfall.size, maxsize= downfall.size,
			collisiondetection = true, collision_removal = true,
			vertical = true,
			texture = downfall_texture, playername = _player_name
		})

		--Lightning
		if self.downfall_type == "storm" and climaz.settings.lightning then
			local lightning = _player:get_meta():get_int("climaz:lightning")
			--minetest.chat_send_all(tostring(lightning))
			--minetest.chat_send_all(tonumber(timer))
			if lightning <= 0  then
				local chance = math.random(climaz.settings.lightning_chance)
				if chance == 1 then
					if is_on_surface(_player_pos) then
						show_lightning(_player_name)
						minetest.after(climaz.settings.lightning_duration, remove_lightning, _player_name)
					end
				end
			end
		end

		if climaz.settings.climate_rain_sound
			and (self.downfall_type == "rain" or self.downfall_type == "storm") then
				local rain_sound_handle = self.players[_player_name].rain_sound_handle
				if rain_sound_handle and not(is_on_surface(_player_pos)) then
					self:stop_rain_sound(_player_name, rain_sound_handle)
				elseif not(rain_sound_handle) and is_on_surface(_player_pos) then
					self:start_rain_sound(_player_name)
				end
		end

		--minetest.chat_send_all("Climate created by ".._player_name)
	end,

	add_player = function(self, player_name, climate_id, downfall_type, underwater)

		local player = minetest.get_player_by_name(player_name)

		self.players[player_name] = {
			climate_id = climate_id,
			sky_color = nil,
			clouds_color = nil,
			clouds_density = nil,
			rain_sound_handle = nil,
			hud_id = nil,
			downfall_type = downfall_type,
			underwater = underwater,
		}

		local downfall_sky_color, downfall_clouds_color, downfall_clouds_density

		if downfall_type == "rain" or downfall_type == "storm" or downfall_type == "snow" then
			downfall_sky_color = "#808080"
			downfall_clouds_color = "#C0C0C0"
			downfall_clouds_density = 0.9
		else --"sand"
			downfall_sky_color = "#DEB887"
			downfall_clouds_color = "#DEB887"
			downfall_clouds_density = 0.8
		end

		self.players[player_name].sky_color = player:get_sky().sky_color or "#8cbafa"
		player:set_sky({
			sky_color = {
				day_sky = downfall_sky_color,
			}
		})
		self.players[player_name].clouds_color = player:get_clouds().color or "#fff0f0e5"
		self.players[player_name].clouds_density = player:get_clouds().density or 0.4
		player:set_clouds({
			color = downfall_clouds_color,
			density = downfall_clouds_density
		})
		if player.set_lighting then --allow older MT to work
			player:set_lighting({shadows = {intensity = 0.6 * (1 - downfall_clouds_density)}})
		end

		if downfall_type == "sand" and climaz.settings.dust_effect then
			self.players[player_name].hud_id = player:hud_add({
				hud_elem_type = "image",
				text = "climaz_dust.png",
				position = {x=0, y=0},
				scale = {x=-100, y=-100},
				alignment = {x=1, y=1},
				offset = {x=0, y=0}
			})
		end

		--if climaz.settings.climate_rain_sound and (downfall_type == "rain" or downfall_type== "storm")
			--and is_on_surface(player:get_pos()) then
				--self:start_rain_sound(player_name)
		--end

		set_player_climate_id(player_name, climate_id)

		--minetest.chat_send_all(player_name.." added to climate "..tostring(climate_id))
	end,

	remove_climate_player_effects = function(self, player_name)
		local player = minetest.get_player_by_name(player_name)
		if not player then
			return
		end
		player:set_sky({
			sky_color = {
				day_sky = self.players[player_name].sky_color,
			}
		})
		local cloud_density = self.players[player_name].clouds_density;
		player:set_clouds({
			color = self.players[player_name].clouds_color,
			density = cloud_density,
		})
		if player.set_lighting then --allow older MT to work
			player:set_lighting({shadows = {intensity = 0.6 * (1 - cloud_density)}})
		end

		local downfall_type = self.players[player_name].downfall_type

		local rain_sound_handle = self.players[player_name].rain_sound_handle
		if rain_sound_handle and climaz.settings.climate_rain_sound
			and (downfall_type == "rain" or downfall_type == "storm") then
				self:stop_rain_sound(player_name, rain_sound_handle)
		end

		if downfall_type == "sand" and climaz.settings.dust_effect then
			player:hud_remove(self.players[player_name].hud_id)
		end

		local lightning = player:get_meta():get_int("climaz:lightning")
		if downfall_type == "storm" and lightning > 0 then
			remove_lightning(player_name)
		end
	end,

	remove_player = function(self, player_name)
		self:remove_climate_player_effects(player_name)
		--remove the player-->
		self.players = remove_table_by_key(self.players, player_name)
		reset_player_climate_id(player_name)
	end,

	start_rain_sound = function(self, player_name)
		local rain_sound_handle = minetest.sound_play("climaz_rain", {
			to_player = player_name,
			loop = true,
			gain = climaz.settings.rain_sound_gain
		})
		self.players[player_name].rain_sound_handle = rain_sound_handle
	end,

	stop_rain_sound = function(self, player_name, rain_sound_handle)
		minetest.sound_stop(rain_sound_handle)
		self.players[player_name].rain_sound_handle = nil
	end

}

--This also sets the shadow intensity
--(for Minetest versions that support it).
minetest.register_on_joinplayer(function(player)
	reset_player_climate_id(player:get_player_name())
	if player.set_lighting then --allow older MT to work
		player:set_lighting({shadows = {intensity = 0.6 * (1 - player:get_clouds().density or 0.4)}})
	end
end)

--CLIMATE CORE: GLOBALSTEP

minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer >= 1 then
		for _, player in ipairs(minetest.get_connected_players()) do
			local player_name = player:get_player_name()
			local player_pos = player:get_pos()
			local current_climate_id = get_player_climate_id(player)
			local inside_climate_id, underwater = climaz.is_inside_climate(player_pos)
			--minetest.chat_send_all(tostring(inside_climate_id))
			--minetest.chat_send_all(tostring(current_climate_id))
			if current_climate_id then
				local _remove_player
				if not(current_climate_id == inside_climate_id) then --IMPORTANT: this comparation should be in this order!!!
					_remove_player = true
					--minetest.chat_send_all(player_name.." abandoned a climate")
				end
				local player_in_climate = climaz.climates[current_climate_id].players[player_name]
				if player_in_climate and underwater then
					player_in_climate.underwater = true --mark as underwater
				else
					player_in_climate.underwater = false
				end
				if _remove_player then
					if climaz.climates[current_climate_id] then
						climaz.climates[current_climate_id]:remove_player(player_name)
					else
						reset_player_climate_id(player_name)
					end
				end
			elseif inside_climate_id and not(current_climate_id) then --another player enter into the climate
				local downfall_type = climaz.climates[inside_climate_id].downfall_type
				climaz.climates[inside_climate_id]:add_player(player_name, inside_climate_id, downfall_type, underwater)
				--minetest.chat_send_all(player_name.." entered into the climate")
				--minetest.chat_send_all("climate_id= "..tostring(climate_id)..", _climate?= "..tostring(_climate))
			elseif not(current_climate_id) and not(inside_climate_id) then --chance to create a climate
				local chance = math.random(climaz.settings.climate_change_ratio)
				if chance == 1 then
					local new_climate_id = get_id()
					climaz.climates[new_climate_id] = climate:new(new_climate_id, player_name, underwater)
					--minetest.chat_send_all(player_name.." created a climate id="..new_climate_id)
				end
			end
		end
		timer = 0
	end

	for _id, _climate in pairs(climaz.climates) do
		--Update the climate timers
		_climate.timer = _climate.timer + dtime
		_climate:on_timer()
		for _player_name in pairs(_climate.players) do
			if minetest.get_player_by_name(_player_name) then
				_climate:apply(_player_name)
			else --remove player from climate
				climaz.climates[_id]:remove_player(_player_name)
			end
		end
	end
end)

--COMMANDS

minetest.register_chatcommand("climaz", {
	privs = {
        server = true,
    },
	description = "Climate Functions",
    func = function(name, param)
		local subcommand, player_name
		local i = 0
		for word in string.gmatch(param, "([%a%d_-]+)") do
			if i == 0 then
				subcommand = word
			else
				player_name = word
			end
			i = i + 1
		end
		if not(subcommand == "stop") and not(subcommand == "start") then
			return true, "Error: The subcomands for the climatez command are 'stop | start'"
		end
		--if subcommand then
			--minetest.chat_send_all("subcommand =".. subcommand)
		--end
		--if player_name then
			--minetest.chat_send_all("player name =".. player_name)
		--end
		if subcommand == "stop" then
			if player_name then --remove the climate only for that player
				local player = minetest.get_player_by_name(player_name)
				if player then
					local climate_id = get_player_climate_id(player)
					if climate_id then
						climaz.climates[climate_id]:remove_player(player_name)
					else
						minetest.chat_send_player(player_name, player_name .. " ".. "is not inside any climate.")
					end
				else
					minetest.chat_send_player(name, "The player "..player_name.." is not online.")
				end
			else
				local player = minetest.get_player_by_name(name)
				if player then
					local climate_id = get_player_climate_id(player)
					if climate_id then
						climaz.climates[climate_id]:stop()
					else
						minetest.chat_send_player(name, "You are not inside any climate.")
					end
				end
			end
		elseif subcommand == "start" then
			local player = minetest.get_player_by_name(name)
			if player then
				local climate_id = get_player_climate_id(player)
				if climate_id then
					climaz.climates[climate_id]:stop()
				end
				local new_climate_id = get_id()
				climaz.climates[new_climate_id] = climate:new(new_climate_id, name)
			end
		end
    end,
})
