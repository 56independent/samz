foodz = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

assert(loadfile(modpath .. "/api.lua"))(S, modname)
assert(loadfile(modpath .. "/bread.lua"))()
assert(loadfile(modpath .. "/candy.lua"))()
assert(loadfile(modpath .. "/icecream.lua"))()
assert(loadfile(modpath .. "/oil.lua"))()
