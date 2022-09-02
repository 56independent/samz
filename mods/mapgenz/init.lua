mapgenz = {
	biomes = {}
}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

local mg_name = minetest.get_mapgen_setting("mg_name")

if mg_name == "valleys" then
	mapgenz.biomes.peaky_mountain_height = 85
elseif mg_name == "carphatian" then
	mapgenz.biomes.peaky_mountain_height = 65
elseif mg_name == "v7"  then
	mapgenz.biomes.peaky_mountain_height = 45
else
	mapgenz.biomes.peaky_mountain_height = 55
end

mapgenz.biomes.swamp_height = 7

--
-- Aliases for map generator outputs
--

-- ESSENTIAL node aliases
-- Basic nodes
minetest.register_alias("mapgen_stone", "nodez:stone")
minetest.register_alias("mapgen_water_source", "nodez:water_source")
minetest.register_alias("mapgen_river_water_source", "nodez:river_water_source")

-- Additional essential aliases for v6
minetest.register_alias("mapgen_lava_source", "nodez:lava_source")
minetest.register_alias("mapgen_dirt", "nodez:dirt")
minetest.register_alias("mapgen_dirt_with_grass", "nodez:dirt_with_grass")
minetest.register_alias("mapgen_sand", "nodez:sand")
minetest.register_alias("mapgen_tree", "nodez:tree")
minetest.register_alias("mapgen_leaves", "nodez:leaves")
minetest.register_alias("mapgen_apple", "nodez:apple")

-- Essential alias for dungeons
minetest.register_alias("mapgen_cobble", "nodez:cobble")

-- Optional aliases for v6 (they all have fallback values in the engine)
if minetest.settings:get_bool("devtest_v6_mapgen_aliases", false) then
	minetest.register_alias("mapgen_gravel", "nodez:gravel")
	minetest.register_alias("mapgen_desert_stone", "nodez:desert_stone")
	minetest.register_alias("mapgen_desert_sand", "nodez:desert_sand")
	minetest.register_alias("mapgen_dirt_with_snow", "nodez:dirt_with_snow")
	minetest.register_alias("mapgen_snowblock", "nodez:snowblock")
	minetest.register_alias("mapgen_snow", "nodez:snow")
	minetest.register_alias("mapgen_ice", "nodez:ice")
	minetest.register_alias("mapgen_junglegrass", "nodez:junglegrass")
	minetest.register_alias("mapgen_jungletree", "nodez:jungletree")
	minetest.register_alias("mapgen_jungleleaves", "nodez:jungleleaves")
	minetest.register_alias("mapgen_pine_tree", "nodez:pine_tree")
	minetest.register_alias("mapgen_pine_needles", "nodez:pine_needles")
end
-- Optional alias for mossycobble (should fall back to cobble)
if minetest.settings:get_bool("devtest_dungeon_mossycobble", false) then
	minetest.register_alias("mapgen_mossycobble", "nodez:mossycobble")
end
-- Optional aliases for dungeon stairs (should fall back to full nodes)
if minetest.settings:get_bool("devtest_dungeon_stairs", false) then
	minetest.register_alias("mapgen_stair_cobble", "stairs:stair_cobble")
	if minetest.settings:get_bool("devtest_v6_mapgen_aliases", false) then
		minetest.register_alias("mapgen_stair_desert_stone", "stairs:stair_desert_stone")
	end
end

assert(loadfile(modpath .. "/biomes.lua"))(mg_name)
assert(loadfile(modpath .. "/ores.lua"))()
assert(loadfile(modpath .. "/deco.lua"))()
