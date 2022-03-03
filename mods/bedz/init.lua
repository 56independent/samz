bedz = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)
assert(loadfile(modpath .. "/api.lua"))(modname)
assert(loadfile(modpath .. "/beds.lua"))(S)
