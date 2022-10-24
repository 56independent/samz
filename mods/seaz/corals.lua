local corals= {
	green_coral = {
		description= "Green Coral",
		tiles = "seaz_green_coral_base.png",
		special_tiles = "seaz_green_coral_top.png",
	},
	orange_coral = {
		description= "Orange Coral",
		tiles = "seaz_orange_coral_base.png",
		special_tiles = "seaz_orange_coral_top.png"
	},
	blue_coral = {
		description= "Blue Coral",
		tiles = "seaz_blue_coral_base.png",
		special_tiles = "seaz_blue_coral_top.png"
	},
}

for name, def in pairs(corals) do
	seaz.register_coral(name, def)
end

seaz.register_coral_deco(corals)
