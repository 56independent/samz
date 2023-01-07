--Define the colors for dyes
--See the /samz/textures/palette256 for the colors
dyez.colors = {
	white =  {nil, nil, 0},
	red = {nil, "#c73442", 1},
	blue = {nil, "#628df0", 2},
	green = {nil, "#4b7d31", 3},
	yellow = {nil, "#ffff4d", 4},
	pink = {nil, "#cf6593", 5},
	violet = {nil, "#6c54a1", 6},
	orange = {nil, "#f58318", 7},
	brown = {nil, "#946248", 8},
	navy = {nil, "#2f374d", 9},
	darkgreen = {"Dark Green", "#1f5632", 10},
	gray = {nil, nil, 11},
	darkgray = {"Dark Gray", "#6a6a6a", 12},
	black = {nil, nil, 13}
}

--Register dyes
for color, def in pairs(dyez.colors) do
	dyez.register_dye(color, def)
end
