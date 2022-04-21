local S, farmz_mod = ...

local dirt_grass_time = 1200

local function remove_plow(pos)
	if helper.in_group(pos, "plow") or helper.in_group(pos, "plant") then
		minetest.swap_node(pos, {name="air"})
	end
end

local function destroy_plow(pos)
	if not farmz_mod then
		return
	end
	remove_plow({x=pos.x, y=pos.y+1, z=pos.z})
end

minetest.register_node("nodez:dirt", {
	description = S("Dirt"),
	tiles = {"nodez_dirt.png"},
	groups = {crumbly=3, dirt=1, soil=1},
	sounds = sound.dirt(),

	on_destruct = function(pos)
		destroy_plow(pos)
	end,

	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local node = minetest.get_node_or_nil(pos)
		if node then
			node.param2 = 1
		end
		minetest.get_node_timer(pos):start(dirt_grass_time)
	end,

	on_timer = function(pos, elapsed)
		minetest.swap_node(pos, {name = "nodez:dirt_with_grass"})
		return false
	end
})

minetest.register_node("nodez:dirt_with_grass", {
	description = S("Dirt with Grass"),
	tiles ={"nodez_grass.png",
		-- a little dot on the bottom to distinguish it from dirt
		"nodez_dirt.png",
		{name = "nodez_dirt.png^nodez_grass_side.png",
		tileable_vertical = false}},
	groups = {crumbly=3, dirt=1, soil=1},
	sounds = sound.dirt(),
	on_destruct = function(pos)
		destroy_plow(pos)
	end
})

--Snow

minetest.register_node("nodez:dirt_with_snow", {
	description = S("Dirt with Snow"),
	tiles = {"nodez_snow.png", "nodez_dirt.png",
		{name = "nodez_dirt.png^nodez_snow_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1, snowy = 1},
	drop = "nodez:dirt",
	sounds = sound.dirt({
		footstep = {name = "sound_snow_footstep", gain = 0.2},
	}),
	on_destruct = function(pos)
		destroy_plow(pos)
	end
})

--Pottery

minetest.register_node("nodez:clay", {
	description = S("Clay"),
	tiles ={"nodez_clay.png"},
	groups = {crumbly=2, pottery =1},
	sounds = sound.dirt(),
})

minetest.register_craftitem("nodez:clay_lump", {
	description = S("Clay Lump"),
	groups = {pottery =1},
	inventory_image = "nodez_clay_lump.png"
})

minetest.register_craft({
	output = "nodez:clay 1",
	type = "shapeless",
	recipe = {
		"nodez:clay_lump", "nodez:clay_lump",
		"nodez:clay_lump", "nodez:clay_lump",
	}
})

minetest.register_craft({
	output = "nodez:clay 1",
	type = "shapeless",
	recipe = {"group:water", "group:dirt"}
})

minetest.register_craft({
	type = "shapeless",
	output = "nodez:clay_lump 4",
	recipe = {"nodez:clay"}
})

--Clay Bricks

minetest.register_craftitem("nodez:clay_brick", {
	description = S("Clay Brick"),
	inventory_image = "nodez_clay_brick.png",
	groups = {pottery=1, build=1},
})

minetest.register_craft({
	type = "cooking",
	output = "nodez:clay_brick",
	recipe = "nodez:clay_lump",
	cooktime = 7,
})

minetest.register_node("nodez:clay_bricks", {
	description = S("Clay Bricks"),
	tiles ={"nodez_clay_bricks.png"},
	groups = {cracky = 3, pottery =1, build=1},
	sounds = sound.stone(),
})

minetest.register_craft({
	output = "nodez:clay_bricks 1",
	type = "shapeless",
	recipe = {
		"nodez:clay_brick", "nodez:clay_brick",
		"nodez:clay_brick", "nodez:clay_brick",
	}
})

--Adobe

minetest.register_node("nodez:adobe", {
	description = S("Adobe"),
	tiles ={"nodez_adobe.png"},
	groups = {crumbly=2, pottery=1, build=1},
	sounds = sound.dirt(),
})

minetest.register_craft({
	output = "nodez:adobe",
	type = "shapeless",
	recipe = {
		"nodez:clay", "nodez:sand",
		"farmz:wheat"
	}
})
