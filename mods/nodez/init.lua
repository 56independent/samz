--
-- Nodez
--

nodez = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

assert(loadfile(modpath .. "/dirt.lua"))(S)
assert(loadfile(modpath .. "/gems.lua"))(S)
assert(loadfile(modpath .. "/grass.lua"))(S)
assert(loadfile(modpath .. "/lava.lua"))(S)
assert(loadfile(modpath .. "/ore.lua"))(S)
assert(loadfile(modpath .. "/sand.lua"))(S)
assert(loadfile(modpath .. "/stone.lua"))(S)
assert(loadfile(modpath .. "/water.lua"))(S)

