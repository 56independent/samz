unused_args = false
allow_defined_top = false
max_line_length = false

globals = {
	"eatz",
	"bedz",
	"boomz",
	"bucketz",
	"chestz",
	"climaz",
	"closetz",
	"clothz",
	"decoz",
	"doorz",
	"farmz",
	"fencez",
	"floraz",
	"flowerz",
	"foodz",
    "furnz",
    "helper",
    "itemz",
    "kitz",
	"minetest",
	"mirrorz",
	"mg_name",
	"modname",
	"nodez",
	"ladderz",
	"playerz",
	"playerphysics",
	"S",
	"samz",
	"screwz",
	"sfinv",
    "sound",
    "stairz",
    "svrz",
    "throwz",
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
