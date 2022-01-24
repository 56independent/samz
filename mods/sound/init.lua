--
-- Sound
--

sound = {}

function sound.defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "", gain = 1.0}
	table.dug = table.dug or
			{name = "sound_dug_node", gain = 0.25}
	table.place = table.place or
			{name = "sound_place_node_hard", gain = 1.0}
	return table
end

function sound.stone(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "sound_hard_footstep", gain = 0.3}
	table.dug = table.dug or
			{name = "sound_hard_footstep", gain = 1.0}
	sound.defaults(table)
	return table
end

function sound.dirt(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "sound_dirt_footstep", gain = 0.4}
	table.dug = table.dug or
			{name = "sound_dirt_footstep", gain = 1.0}
	table.place = table.place or
			{name = "sound_place_node", gain = 1.0}
	sound.defaults(table)
	return table
end

function sound.sand(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "sound_sand_footstep", gain = 0.05}
	table.dug = table.dug or
			{name = "sound_sand_footstep", gain = 0.15}
	table.place = table.place or
			{name = "sound_place_node", gain = 1.0}
	sound.defaults(table)
	return table
end

function sound.gravel(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "sound_gravel_footstep", gain = 0.1}
	table.dig = table.dig or
			{name = "sound_gravel_dig", gain = 0.35}
	table.dug = table.dug or
			{name = "sound_gravel_dug", gain = 1.0}
	table.place = table.place or
			{name = "sound_place_node", gain = 1.0}
	sound.defaults(table)
	return table
end

function sound.wood(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "sound_wood_footstep", gain = 0.3}
	table.dug = table.dug or
			{name = "sound_wood_footstep", gain = 1.0}
	sound.defaults(table)
	return table
end

function sound.leaves(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "sound_grass_footstep", gain = 0.45}
	table.dug = table.dug or
			{name = "sound_grass_footstep", gain = 0.7}
	table.place = table.place or
			{name = "sound_place_node", gain = 1.0}
	sound.defaults(table)
	return table
end

function sound.glass(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "sound_glass_footstep", gain = 0.3}
	table.dig = table.dig or
			{name = "sound_glass_footstep", gain = 0.5}
	table.dug = table.dug or
			{name = "sound_break_glass", gain = 1.0}
	sound.defaults(table)
	return table
end

function sound.ice(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "sound_ice_footstep", gain = 0.3}
	table.dig = table.dig or
			{name = "sound_ice_dig", gain = 0.5}
	table.dug = table.dug or
			{name = "sound_ice_dug", gain = 0.5}
	sound.defaults(table)
	return table
end

function sound.metal(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "sound_metal_footstep", gain = 0.4}
	table.dig = table.dig or
			{name = "sound_dig_metal", gain = 0.5}
	table.dug = table.dug or
			{name = "sound_dug_metal", gain = 0.5}
	table.place = table.place or
			{name = "sound_place_node_metal", gain = 0.5}
	sound.defaults(table)
	return table
end

function sound.water(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "sound_water_footstep", gain = 0.2}
	sound.defaults(table)
	return table
end

function sound.snow(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "sound_snow_footstep", gain = 0.2}
	table.dig = table.dig or
			{name = "sound_snow_footstep", gain = 0.3}
	table.dug = table.dug or
			{name = "sound_snow_footstep", gain = 0.3}
	table.place = table.place or
			{name = "sound_place_node", gain = 1.0}
	sound.defaults(table)
	return table
end
