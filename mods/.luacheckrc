unused_args = false
allow_defined_top = false
max_line_length = false

globals = {
	"eat",
	"bedz",
	"farmz",
	"flowers",
    "furn",
    "helper",
	"minetest",
	"nodez",
	"playerz",
	"playerphysics",
	"samz",
	"sfinv",
    "sound",
    "stairs",
    "svrz",
    "treez",
    "wield3d",
	"mapgen",
}

read_globals = {
    string = {fields = {"split"}},
    table = {fields = {"copy", "getn"}},

    -- Builtin
    "vector", "ItemStack", "math",
    "dump", "DIR_DELIM", "VoxelArea", "Settings",

    -- MTG
    "default", "sfinv", "creative",
}
