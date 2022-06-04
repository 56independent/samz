boomz = {}


local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

assert(loadfile(modpath .. "/api.lua"))()
assert(loadfile(modpath .. "/bombs.lua"))(S)
