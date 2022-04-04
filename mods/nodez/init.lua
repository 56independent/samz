--
-- Nodez
--

nodez = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

local farmz_mod

if minetest.get_modpath("farmz") ~= nil then
	farmz_mod = true
end

assert(loadfile(modpath .. "/dirt.lua"))(S, farmz_mod)
assert(loadfile(modpath .. "/gems.lua"))(S)
assert(loadfile(modpath .. "/metals.lua"))(S)
assert(loadfile(modpath .. "/mese.lua"))(S)
assert(loadfile(modpath .. "/lava.lua"))(S)
assert(loadfile(modpath .. "/ore.lua"))(S)
assert(loadfile(modpath .. "/roofs.lua"))(S, modname)
assert(loadfile(modpath .. "/sand.lua"))(S)
assert(loadfile(modpath .. "/stone.lua"))(S)
assert(loadfile(modpath .. "/water.lua"))(S)

