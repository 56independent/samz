unused_args = false
allow_defined_top = false
max_line_length = false

globals = {
	"eatz",
	"bedz",
	"bucketz",
	"decoz",
	"doorz",
	"farmz",
	"flowerz",
    "furnz",
    "helper",
    "itemz",
    "kitz",
	"minetest",
	"modname",
	"nodez",
	"playerz",
	"playerphysics",
	"S",
	"samz",
	"sfinv",
    "sound",
    "stairz",
    "svrz",
    "toolz",
    "torchz",
    "treez",
    "wield3d",
	"mapgenz",
	"wikiz"
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
