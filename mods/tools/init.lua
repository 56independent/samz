tools = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

assert(loadfile(modpath .. "/axes.lua"))(S)
assert(loadfile(modpath .. "/hand.lua"))()
assert(loadfile(modpath .. "/pickaxes.lua"))(S)
assert(loadfile(modpath .. "/shears.lua"))(S)
assert(loadfile(modpath .. "/shovels.lua"))(S)
assert(loadfile(modpath .. "/swords.lua"))(S)

