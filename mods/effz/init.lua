effz = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

assert(loadfile(modpath .. "/api.lua"))()
assert(loadfile(modpath .. "/effects.lua"))()
