S, modname = ...

-- Flower registration

local function register_flower_deco(name, deco)

	if not(deco.noise_params) then
		deco.noise_params = {
			scale = 0.04
		}
	end

	local flower_name = modname..":"..name

	minetest.register_decoration({
		name = flower_name,
		decoration = flower_name,
		deco_type = deco.type or "simple",
		place_on = deco.place_on,
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = deco.noise_params.scale or 0.04,
			spread = {x = 200, y = 200, z = 200},
			seed = deco.seed,
			octaves = 3,
			persist = 0.6
		},
		biomes = deco.biomes,
		y_max = deco.height.y_max,
		y_min = deco.height.y_min,
		schematic = deco.schematic,
		flags = deco.flags or "",
		place_offset_y = deco.place_offset_y or 0
	})
end

function flowers.register_flower(name, def)
	-- Common flowers' groups
	def.groups.snappy = 3
	def.groups.flower = 1
	def.groups.flora = 1
	def.groups.attached_node = 1

	local inventory_image =  modname.."_" .. name
	if def.inv_img then
		inventory_image = inventory_image .. "_inv"
	end

	minetest.register_node(modname..":" .. name, {
		description = S(def.desc),
		drawtype = "plantlike",
		waving = 1,
		tiles = {"flowers_" .. name .. ".png"},
		inventory_image = inventory_image .. ".png",
		wield_image =  "flowers_" .. name .. ".png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		groups = def.groups,
		sounds = sound.leaves(),
		selection_box = {
			type = "fixed",
			fixed = def.box
		}
	})

	if def.deco then
		register_flower_deco(name, def.deco)
	end
end

function flowers.register_tall_flower(name, def)

	local flower_name = modname .. ":" .. name
	local flower_name_top = flower_name .. "_top"

	-- Common flowers' groups
	def.groups.snappy = 3
	def.groups.flower = 1
	def.groups.flora = 1
	def.groups.attached_node = 1

	local groups_top = helper.table_shallowcopy(def.groups)
	groups_top.not_in_creative_inventory = 1

	minetest.register_node(flower_name_top, {
		description = S(def.desc),
		drawtype = "plantlike",
		visual_scale = 1.0,
		tiles = {"flowers_"..name.."_top.png"},
		inventory_image = "flowers_"..name.."_top_inv.png",
		paramtype = "light",
		walkable = true,
		waving = 1,
		groups = groups_top,
		sounds = sound.leaves(),
		drop = flower_name,
		selection_box = {
			type = "fixed",
			fixed = def.box
		},
		after_destruct = function(pos, oldnode)
			pos.y = pos.y - 1
			local node = minetest.get_node_or_nil(pos)
			if node and node.name == flower_name then
				minetest.remove_node(pos)
			end
		end
	})

	minetest.register_node(flower_name, {
		description = S(def.desc),
		drawtype = "plantlike",
		visual_scale = 1.0,
		tiles = {"flowers_"..name.."_bottom.png"},
		inventory_image = "flowers_"..name.."_top.png",
		wield_image = "flowers_"..name.."_top.png",
		paramtype = "light",
		walkable = true,
		waving = 1,
		groups = {snappy = 3, flammable = 3, flower =1, flora=1, attached_node = 1},
		sounds = sound.leaves(),
		selection_box = {
			type = "fixed",
			fixed = def.box
		},

		on_place = function(itemstack, placer, pointed_thing)
			if not(pointed_thing.type) == "node" then
				return
			end
			local pos_above = minetest.get_pointed_thing_position(pointed_thing, true)
			local pos_sunflower_top = pos_above
			pos_sunflower_top.y = pos_sunflower_top.y + 1
			local node = minetest.get_node_or_nil(pos_sunflower_top)
			if node and node.name == "air" then
				pos_above.y = pos_above.y - 1
				minetest.set_node(pos_above, {name = flower_name})
				local player_name = placer and placer:get_player_name() or ""
				if not (creative and creative.is_enabled_for
					and creative.is_enabled_for(player_name)) then
						itemstack:take_item()
				end
				return itemstack
			end
		end,

		on_construct = function(pos)
			pos.y = pos.y + 1
			minetest.place_node(pos, {name = flower_name_top})
		end,

		after_destruct = function(pos, oldnode)
			pos.y = pos.y + 1
			local node = minetest.get_node_or_nil(pos)
			if node and node.name == flower_name_top then
				minetest.remove_node(pos)
			end
		end
	})

	if def.deco then
		def.deco.schematic = {
			size = {x = 1, y = 2, z = 1},
			data = {
				{name = flower_name}, {name = flower_name_top},
			}
		}
		register_flower_deco(name, def.deco)
	end
end
