--
-- Tool definitions
--

--[[ TOOLS SUMMARY:

Tool types:

* Hand: basic tool/weapon (special capabilities in creative mode)
* Pickaxe: dig cracky
* Axe: dig choppy
* Shovel: dig crumbly
* Shears: dig snappy
* Sword: deal damage
* Dagger: deal damage, but faster

Tool materials:

* Wood: dig nodes of rating 3
* Stone: dig nodes of rating 3 or 2
* Steel: dig nodes of rating 3, 2 or 1
* Mese: dig "everything" instantly
* n-Uses: can be used n times before breaking
]]

-- The hand
if minetest.settings:get_bool("creative_mode") then
	local digtime = 42
	local caps = {times = {digtime, digtime, digtime}, uses = 0, maxlevel = 256}

	minetest.register_item(":", {
		type = "none",
		wield_image = "wieldhand.png",
		wield_scale = {x = 1, y = 1, z = 2.5},
		range = 10,
		tool_capabilities = {
			full_punch_interval = 0.5,
			max_drop_level = 3,
			groupcaps = {
				crumbly = caps,
				cracky  = caps,
				snappy  = caps,
				choppy  = caps,
				oddly_breakable_by_hand = caps,
				-- dig_immediate group doesn't use value 1. Value 3 is instant dig
				dig_immediate =
					{times = {[2] = digtime, [3] = 0}, uses = 0, maxlevel = 256},
			},
			damage_groups = {fleshy = 10},
		}
	})
else
	minetest.register_item(":", {
		type = "none",
		wield_image = "wieldhand.png",
		wield_scale = {x = 1, y = 1, z = 2.5},
		tool_capabilities = {
			full_punch_interval = 0.9,
			max_drop_level = 0,
			groupcaps = {
				crumbly = {times = {[2] = 3.00, [3] = 0.70}, uses = 0, maxlevel = 1},
				snappy = {times = {[3] = 0.40}, uses = 0, maxlevel = 1},
				oddly_breakable_by_hand =
					{times = {[1] = 3.50, [2] = 2.00, [3] = 0.70}, uses = 0}
			},
			damage_groups = {fleshy = 1},
		}
	})
end

-- Mese Pickaxe: special tool that digs "everything" instantly
minetest.register_tool("tools:pick_mese", {
	description = "Mese Pickaxe".."\n"..
			"Digs diggable nodes instantly",
	inventory_image = "tools_mesepick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			cracky={times={[1]=0.0, [2]=0.0, [3]=0.0}, maxlevel=255},
			crumbly={times={[1]=0.0, [2]=0.0, [3]=0.0}, maxlevel=255},
			snappy={times={[1]=0.0, [2]=0.0, [3]=0.0}, maxlevel=255},
			choppy={times={[1]=0.0, [2]=0.0, [3]=0.0}, maxlevel=255},
			dig_immediate={times={[1]=0.0, [2]=0.0, [3]=0.0}, maxlevel=255},
		},
		damage_groups = {fleshy=100},
	},
})


--
-- Pickaxes: Dig cracky
--

minetest.register_tool("tools:pick_wood", {
	description = "Wooden Pickaxe".."\n"..
		"Digs cracky=3",
	inventory_image = "tools_woodpick.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			cracky={times={[3]=2.00}, uses=30, maxlevel=0}
		},
	},
})
minetest.register_tool("tools:pick_stone", {
	description = "Stone Pickaxe".."\n"..
		"Digs cracky=2..3",
	inventory_image = "tools_stonepick.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			cracky={times={[2]=1.20, [3]=0.80}, uses=60, maxlevel=0}
		},
	},
})
minetest.register_tool("tools:pick_steel", {
	description = "Steel Pickaxe".."\n"..
		"Digs cracky=1..3",
	inventory_image = "tools_steelpick.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			cracky={times={[1]=4.00, [2]=1.60, [3]=1.00}, uses=90, maxlevel=0}
		},
	},
})
minetest.register_tool("tools:pick_steel_l1", {
	description = "Steel Pickaxe Level 1".."\n"..
		"Digs cracky=1..3".."\n"..
		"maxlevel=1",
	inventory_image = "tools_steelpick_l1.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			cracky={times={[1]=4.00, [2]=1.60, [3]=1.00}, uses=90, maxlevel=1}
		},
	},
})
minetest.register_tool("tools:pick_steel_l2", {
	description = "Steel Pickaxe Level 2".."\n"..
		"Digs cracky=1..3".."\n"..
		"maxlevel=2",
	inventory_image = "tools_steelpick_l2.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			cracky={times={[1]=4.00, [2]=1.60, [3]=1.00}, uses=90, maxlevel=2}
		},
	},
})

--
-- Shovels (dig crumbly)
--

minetest.register_tool("tools:shovel_wood", {
	description = "Wooden Shovel".."\n"..
		"Digs crumbly=3",
	inventory_image = "tools_woodshovel.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			crumbly={times={[3]=0.50}, uses=30, maxlevel=0}
		},
	},
})
minetest.register_tool("tools:shovel_stone", {
	description = "Stone Shovel".."\n"..
		"Digs crumbly=2..3",
	inventory_image = "tools_stoneshovel.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			crumbly={times={[2]=0.50, [3]=0.30}, uses=60, maxlevel=0}
		},
	},
})
minetest.register_tool("tools:shovel_steel", {
	description = "Steel Shovel".."\n"..
		"Digs crumbly=1..3",
	inventory_image = "tools_steelshovel.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			crumbly={times={[1]=1.00, [2]=0.70, [3]=0.60}, uses=90, maxlevel=0}
		},
	},
})

--
-- Axes (dig choppy)
--

minetest.register_tool("tools:axe_wood", {
	description = "Wooden Axe".."\n"..
		"Digs choppy=3",
	inventory_image = "tools_woodaxe.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			choppy={times={[3]=0.80}, uses=30, maxlevel=0},
		},
	},
})
minetest.register_tool("tools:axe_stone", {
	description = "Stone Axe".."\n"..
		"Digs choppy=2..3",
	inventory_image = "tools_stoneaxe.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			choppy={times={[2]=1.00, [3]=0.60}, uses=60, maxlevel=0},
		},
	},
})
minetest.register_tool("tools:axe_steel", {
	description = "Steel Axe".."\n"..
		"Digs choppy=1..3",
	inventory_image = "tools_steelaxe.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.00, [2]=0.80, [3]=0.40}, uses=90, maxlevel=0},
		},
	},
})

--
-- Shears (dig snappy)
--

minetest.register_tool("tools:shears_wood", {
	description = "Wooden Shears".."\n"..
		"Digs snappy=3",
	inventory_image = "tools_woodshears.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			snappy={times={[3]=1.00}, uses=30, maxlevel=0},
		},
	},
})
minetest.register_tool("tools:shears_stone", {
	description = "Stone Shears".."\n"..
		"Digs snappy=2..3",
	inventory_image = "tools_stoneshears.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.00, [3]=0.50}, uses=60, maxlevel=0},
		},
	},
})
minetest.register_tool("tools:shears_steel", {
	description = "Steel Shears".."\n"..
		"Digs snappy=1..3",
	inventory_image = "tools_steelshears.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=90, maxlevel=0},
		},
	},
})

--
-- Swords (deal damage)
--

minetest.register_tool("tools:sword_wood", {
	description = "Wooden Sword".."\n"..
		"Damage: fleshy=2",
	inventory_image = "tools_woodsword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		damage_groups = {fleshy=2},
	}
})
minetest.register_tool("tools:sword_stone", {
	description = "Stone Sword".."\n"..
		"Damage: fleshy=4",
	inventory_image = "tools_stonesword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		damage_groups = {fleshy=4},
	}
})
minetest.register_tool("tools:sword_steel", {
	description = "Steel Sword".."\n"..
		"Damage: fleshy=6",
	inventory_image = "tools_steelsword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		damage_groups = {fleshy=6},
	}
})

-- Fire/Ice sword: Deal damage to non-fleshy damage groups
minetest.register_tool("tools:sword_fire", {
	description = "Fire Sword".."\n"..
		"Damage: icy=6",
	inventory_image = "tools_firesword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		damage_groups = {icy=6},
	}
})
minetest.register_tool("tools:sword_ice", {
	description = "Ice Sword".."\n"..
		"Damage: fiery=6",
	inventory_image = "tools_icesword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		damage_groups = {fiery=6},
	}
})

--
-- Dagger: Low damage, fast punch interval
--
minetest.register_tool("tools:dagger_steel", {
	description = "Steel Dagger".."\n"..
		"Damage: fleshy=2".."\n"..
		"Full Punch Interval: 0.5s",
	inventory_image = "tools_steeldagger.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=0,
		damage_groups = {fleshy=2},
	}
})

-- Test tool uses and punch_attack_uses
local uses = { 1, 2, 3, 5, 10, 50, 100, 1000, 10000, 65535 }
for i=1, #uses do
	local u = uses[i]
	local color = string.format("#FF00%02X", math.floor(((i-1)/#uses) * 255))
	minetest.register_tool("tools:pick_uses_"..string.format("%05d", u), {
		description = u.."-Uses Pickaxe".."\n"..
			"Digs cracky=3",
		inventory_image = "tools_steelpick.png^[colorize:"..color..":127",
		tool_capabilities = {
			max_drop_level=0,
			groupcaps={
				cracky={times={[3]=0.1, [2]=0.2, [1]=0.3}, uses=u, maxlevel=0}
			},
		},
	})

	minetest.register_tool("tools:sword_uses_"..string.format("%05d", u), {
		description = u.."-Uses Sword".."\n"..
			"Damage: fleshy=1",
		inventory_image = "tools_woodsword.png^[colorize:"..color..":127",
		tool_capabilities = {
			damage_groups = {fleshy=1},
			punch_attack_uses = u,
		},
	})
end