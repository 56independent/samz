--Define the colors for dyes
--See the /samz/textures/palette256 for the colors
dyez.colors = {
	red = {nil, "#c73442", 0},
	blue = {nil, "#628df0", 1},
	green = {nil, "#4b7d31", 2},
	yellow = {nil, "#ffff4d", 3},
	pink = {nil, "#cf6593", 4},
	violet = {nil, "#6c54a1", 5},
	orange = {nil, "#f58318", 6},
	brown = {nil, "#946248", 7},
	navy = {nil, "#2f374d", 8},
	darkgreen = {"Dark Green", "#1f5632", 9},
	white =  {nil, nil, 10},
	gray = {nil, nil, 11},
	darkgray = {"Dark Gray", "#6a6a6a", 12},
	black = {nil, nil, 13}
}

--Register dyes
for color, def in pairs(dyez.colors) do
	dyez.register_dye(color, def)
end
