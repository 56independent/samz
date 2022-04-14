local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

farmz = {}

assert(loadfile(modpath .. "/api.lua"))(S)
assert(loadfile(modpath .. "/food.lua"))(S)
assert(loadfile(modpath .. "/hoes.lua"))(S)
assert(loadfile(modpath .. "/grasses.lua"))(S)
assert(loadfile(modpath .. "/plants.lua"))()
