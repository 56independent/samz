flowerz = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

assert(loadfile(modpath .. "/api.lua"))(S, modname)
assert(loadfile(modpath .. "/flowers.lua"))(modname)
assert(loadfile(modpath .. "/mushrooms.lua"))()
