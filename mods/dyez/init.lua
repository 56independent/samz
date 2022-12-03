
--
-- dyez
-- License:GPLv3
--

dyez = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

--
-- Dyez Mod
--

-- Load the files
assert(loadfile(modpath .. "/api.lua"))(S, modname)
assert(loadfile(modpath .. "/dyes.lua"))()


