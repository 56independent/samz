unused_args = false
allow_defined_top = false
max_line_length = false

globals = {
    "furn",
	"minetest",
	"nodez",
	"player_api",
	"samz",
	"sfinv",
    "sound",
    "stairs",
    "svrz",
    "treez",
    "wield3d"

}

read_globals = {
    string = {fields = {"split"}},
    table = {fields = {"copy", "getn"}},

    -- Builtin
    "vector", "ItemStack",
    "dump", "DIR_DELIM", "VoxelArea", "Settings",

    -- MTG
    "default", "sfinv", "creative",
}
