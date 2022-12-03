--Define the colors for dyes
dyez.colors = {
	"white", "gray", "darkgray", "black", "violet", "blue", "cyan", "darkgreen", "green", "yellow",
	"brown", "orange", "red", "magenta", "pink"
}

--Register dyes
for _, color in ipairs(dyez.colors) do
	dyez.register_dye(color)
end
