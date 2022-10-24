local kelps = {
	pink_kelp = {
		description = "Pink Kelp",
		texture = "seaz_pink_kelp.png"
	},
}

for name, def in pairs(kelps) do
	seaz.register_kelp(name, def)
end

seaz.register_kelp_deco(kelps)
