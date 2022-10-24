S, modname = ...

function seaz.register_coral(name, def)
	minetest.register_node(modname..":"..name, {
		description = S(def.description),
		drawtype = "plantlike_rooted",
		visual_scale = 1.0,
		tiles = {def.tiles},
		special_tiles = {
			nil,
			nil,
			def.special_tiles,
			def.special_tiles,
			def.special_tiles,
			def.special_tiles
		},
		inventory_image = def.inventory_image or "[inventorycube{"..def.tiles.."{"..def.tiles.."{"..def.tiles,
		paramtype = "light",
		walkable = true,
		groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
		sounds = sound.leaves(),
		--after_place_node = default.after_place_leaves,
	})
end

--Algaes

local function kelp_on_place(itemstack, placer, pointed_thing)
	-- Call on_rightclick if the pointed node defines it
	if pointed_thing.type == "node" and placer and not placer:get_player_control().sneak then
		local node_ptu = minetest.get_node(pointed_thing.under)
		local def_ptu = minetest.registered_nodes[node_ptu.name]
		if def_ptu and def_ptu.on_rightclick then
			return def_ptu.on_rightclick(pointed_thing.under, node_ptu, placer,
				itemstack, pointed_thing)
		end
	end


	local pos = pointed_thing.under
	if minetest.get_node(pos).name ~= "nodez:sand" then
		return itemstack
	end

	local height = math.random(4, 6)
	local pos_top = {x = pos.x, y = pos.y + height, z = pos.z}
	local node_top = minetest.get_node(pos_top)
	local def_top = minetest.registered_nodes[node_top.name]
	local player_name = placer:get_player_name()
	if def_top and def_top.liquidtype == "source" and
			minetest.get_item_group(node_top.name, "water") > 0 then
		if not minetest.is_protected(pos, player_name) and
				not minetest.is_protected(pos_top, player_name) then
			minetest.set_node(pos, {name = itemstack:get_name(),
				param2 = height * 16})
			if not (creative and creative.is_enabled_for
					and creative.is_enabled_for(player_name)) then
				itemstack:take_item()
			end
		else
			minetest.chat_send_player(player_name, S("Node is protected"))
			minetest.record_protection_violation(pos, player_name)
		end
	end
	return itemstack
end

function seaz.register_kelp(name, def)
	minetest.register_node(modname..":"..name, {
		description = S(def.description),
		drawtype = "plantlike_rooted",
		waving = 1,
		tiles = {"nodez_sand.png"},
		special_tiles = {{name = def.texture, tileable_vertical = true}},
		inventory_image = def.inventory or def.texture,
		paramtype = "light",
		paramtype2 = "leveled",
		groups = {snappy = 3},
		selection_box = {
			type = "fixed",
			fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
					{-2/16, 0.5, -2/16, 2/16, 3.5, 2/16},
			},
		},
		node_dig_prediction = "nodez:sand",
		node_placement_prediction = "",
		sounds = sound.sand({
			dig = {name = "default_dig_snappy", gain = 0.2},
			dug = {name = "default_grass_footstep", gain = 0.25},
		}),

		on_place = kelp_on_place,

		after_destruct  = function(pos, oldnode)
			minetest.set_node(pos, {name = "nodez:sand"})
		end
	})
end

function seaz.register_kelp_deco(kelps)
	local kelp_list = {}
	for name, def in pairs(kelps) do
		kelp_list[#kelp_list+1] = modname..":"..name
	end
	minetest.register_decoration({
		name = modname..":kelps",
		decoration = kelp_list,
		deco_type = "simple",
		place_on = {"nodez:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = 0.005,
			scale = 0.004,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {
			"forest_ocean",
			"beach"
		},
		y_max = mapgenz.biomes.ocean_y_max-2,
		y_min = -10,
		flags = "force_placement",
		param2 = 48,
		param2_max = 96,
	})
end

function seaz.register_coral_deco(corals)
	local coral_list = {}
	for name, def in pairs(corals) do
		coral_list[#coral_list+1] = modname..":"..name
	end
	minetest.register_decoration({
		name = modname..":corals",
		decoration = coral_list,
		deco_type = "simple",
		place_on = {"nodez:sand"},
		sidelen = 16,
		noise_params = {
			offset = 0.004,
			scale = 0.005,
			spread = {x = 200, y = 200, z = 200},
			seed = 25345,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"forest_ocean",
			"beach"
		},
		y_max = mapgenz.biomes.ocean_y_max,
		y_min = -10,
		flags = "force_placement",
	})
end
