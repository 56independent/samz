seaz = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

assert(loadfile(modpath .. "/api.lua"))(S, modname)
assert(loadfile(modpath .. "/kelps.lua"))()
assert(loadfile(modpath .. "/corals.lua"))()



