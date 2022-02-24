-- Flower registration

local function register_flower_deco(name, deco)
	if not(deco.noise_params) then
		deco.noise_params = {
			scale = 0.04
		}
	end
	minetest.register_decoration({
		name = "flowers:"..name,
		decoration = "flowers:"..name,
		deco_type = "simple",
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
	})
end

function flowers.register_flower(name, def)
	-- Common flowers' groups
	def.groups.snappy = 3
	def.groups.flower = 1
	def.groups.flora = 1
	def.groups.attached_node = 1

	local inventory_image = "flowers_" .. name
	if def.inv_img then
		inventory_image = inventory_image .. "_inv"
	end

	minetest.register_node("flowers:" .. name, {
		description = def.desc,
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
