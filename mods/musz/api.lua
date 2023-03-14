modname = ...

musz.songs = {}
musz.handles = {}

local song = {
	title = "",
	length = "",
	gain = 0.35,

	add_handle = function(self, player_name, handle)
		musz.handles[player_name] = handle
	end,

	create = function(self, _title, _length, _gain)
		local new_song = self:new()
		new_song.title = _title
		new_song.length = _length
		new_song.gain = _gain or 0.35
		return new_song
	end,

    new = function(self)
		local new_song = {}
		setmetatable(new_song, self)
		self.__index = self
		return new_song
	end,

	play = function(self, player_name)
		musz.remove_handle(player_name)
		local handle = minetest.sound_play(self.title, {to_player= player_name, gain=self.gain})
		if handle then
			self:add_handle(player_name, handle)
			minetest.after(musz.cal_length(self.length)+2, function() --2 seconds of margin
				local player = minetest.get_player_by_name(player_name)
				if not player then
					return
				end
				musz.remove_handle(player_name)
			end)
		end
	end,

	stop = function(player_name)
		minetest.sound_stop(musz.handles[player_name])
		musz.remove_handle(player_name)
	end
}

local songs = {
	{
		title = "Another_Goodbye",
		length = "1:01",
		gain = 0.35,
	},
	{
		title = "Autumn_Changes",
		length = "1:58",
		gain = 0.35,
	},
	{
		title = "More_Tough_Choices",
		length = "2:18",
		gain = 0.35,
	},
	{
		title = "Drinking_Alone",
		length = "1:08",
		gain = 0.35,
	},
	{
		title = "Dusk",
		length = "1:37",
		gain = 0.35,
	},
	{
		title = "Introspection",
		length = "1:14",
		gain = 0.35,
	},
	{
		title = "Space_for_Thought",
		length = "1:45",
		gain = 0.35,
	},
	{
		title = "Book_End",
		length = "1:15",
		gain = 0.35,
	},
	{
		title = "Himalayan_Mind",
		length = "1:42",
		gain = 0.35,
	}
}

for _, _song in pairs(songs) do
	musz.songs[#musz.songs+1] = song:create(_song.title, _song.length, _song.gain)
end

--Background Music Engine

musz.cal_length = function(length_str)
	local timeMinsStr, timeSecsStr = string.match(length_str, "(%d+):(%d+)")
	local timeMins, timeSecs = tonumber(timeMinsStr), tonumber(timeSecsStr)
	return timeMins*60 + timeSecs
end

musz.remove_handle = function(player_name)
	if musz.handles[player_name] then
		musz.handles[player_name] = nil
	end
end

musz.play_a_song = function(player_name)
	local chance = math.random(600, 1200)
	minetest.after(chance, function()
		local player = minetest.get_player_by_name(player_name)
		if not player then
			return
		end
		if not musz.handles[player_name] then
			local song = musz.songs[math.random(1, #songs)]
			song:play(player_name)
		end
		musz.play_a_song(player_name)
	end)
end

--Player Stuff

minetest.register_on_leaveplayer(function(player)
	musz.remove_handle(player:get_player_name())
end)

minetest.register_on_joinplayer(function(player)
	musz.play_a_song(player:get_player_name())
end)
