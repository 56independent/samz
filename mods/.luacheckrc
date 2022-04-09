unused_args = false
allow_defined_top = false
max_line_length = false

globals = {
	"eat",
	"bedz",
	"door",
	"farmz",
	"flowers",
    "furn",
    "helper",
    "items",
	"minetest",
	"modname",
	"nodez",
	"playerz",
	"playerphysics",
	"S",
	"samz",
	"sfinv",
    "sound",
    "stairs",
    "svrz",
    "tools",
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
