fencez = {}

local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

fencez.type = {
	normal = {
		nodebox = {
			fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
			connect_front = {{-1/16,  3/16, -1/2,   1/16,  5/16, -1/8 },
				{-1/16, -5/16, -1/2,   1/16, -3/16, -1/8 }},
			connect_left =  {{-1/2,   3/16, -1/16, -1/8,   5/16,  1/16},
				{-1/2,  -5/16, -1/16, -1/8,  -3/16,  1/16}},
			connect_back =  {{-1/16,  3/16,  1/8,   1/16,  5/16,  1/2 },
				{-1/16, -5/16,  1/8,   1/16, -3/16,  1/2 }},
			connect_right = {{ 1/8,   3/16, -1/16,  1/2,   5/16,  1/16},
				{ 1/8,  -5/16, -1/16,  1/2,  -3/16,  1/16}}
		},
		collision_box = {
			fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
			connect_front = {-1/8, -1/2, -1/2,  1/8, 1/2 , -1/8},
			connect_left =  {-1/2, -1/2, -1/8, -1/8, 1/2 ,  1/8},
			connect_back =  {-1/8, -1/2,  1/8,  1/8, 1/2 ,  1/2},
			connect_right = { 1/8, -1/2, -1/8,  1/2, 1/2 ,  1/8}
		}
	},
	picket = {
		nodebox = {
			disconnected = {{-0.125, -0.5, -0.0625, 0.125, 0.375, 0}, {-0.0625, 0.375, -0.0625, 0.0625, 0.4375, 0}},
			connect_left = {
							{-0.4375, -0.4375, -0.0625, -0.25, 0.375, 0}, {-0.375, 0.375, -0.0625, -0.3125, 0.4375, 0},
							{-0.5, -0.25, 0, 0, -0.125, 0.0625}, {-0.5, 0.125, 0, 0, 0.25, 0.0625}
							},
			connect_right = {
							{0.25, -0.4375, -0.0625, 0.4375, 0.375, 0}, {0.3125, 0.375, -0.0625, 0.375, 0.4375, 0},
							{0, -0.25, 0, 0.5, -0.125, 0.0625}, {0, 0.125, 0, 0.5, 0.25, 0.0625}
							},
			connect_front = {
							{-0.0625, -0.4375, -0.3725, 0, 0.375, -0.1875}, {-0.0625, 0.375, -0.3125, 0, 0.4375, -0.25},
							{0, -0.25, -0.5, 0.0625, -0.125, 0}, {0, 0.125, -0.5, 0.0625, 0.25, 0}
							},
			connect_back = {
							{-0.0625, -0.4375, 0.1875, 0, 0.375, 0.375}, {-0.0625, 0.375, 0.25, 0, 0.4375, 0.3125},
							{0, -0.25, 0, 0.0625, -0.125, 0.5}, {0, 0.125, 0, 0.0625, 0.25, 0.5}
							},
		},
		collision_box = {
			fixed = {-0.125, -0.5, -0.0625, 0.125, 0.4375, 0.0625},
			connect_left = {-0.5, -0.5, -0.0625, -0.125, 0.4375, 0.0625},
			connect_right = {0.125, -0.5, -0.0625, 0.5, 0.4375, 0.0625},
			connect_front = {-0.06225, -0.5, -0.5, 0.0625, 0.4375, -0.0625},
			connect_back = {-0.06225, -0.5, 0.0625, 0.0625, 0.4375, 0.5},
			disconnected = {-0.125, -0.5, -0.0625, 0.125, 0.4375, 0.0625},
		}
	}
}

function fencez.register_fence(name, def)

	local _fence_name = modname..":"..name.."_fence"
	local fence_name = ":".. _fence_name

	minetest.register_craft({
		output = _fence_name .. " 4",
		type = "shaped",
		recipe = {
			{def.material, "group:stick",
			def.material},{"group:stick", "", ""},
			{"", "", ""},
		}
	})

	local overlay = "fencez_fence_overlay_"..def.type..".png"

	local fence_texture = overlay.."^" .. def.texture ..
			"^"..overlay.."^[makealpha:255,126,126"
	-- Allow almost everything to be overridden
	local default_fields = {
		paramtype = "light",
		drawtype = "nodebox",
		node_box = {
			type = "connected",
			fixed = fencez.type[def.type].nodebox.fixed or nil,
			connect_top = fencez.type[def.type].nodebox.connect_top or nil,
			connect_bottom = fencez.type[def.type].nodebox.connect_bottom or nil,
			connect_front = fencez.type[def.type].nodebox.connect_front or nil,
			connect_left = fencez.type[def.type].nodebox.connect_left or nil,
			connect_back = fencez.type[def.type].nodebox.connect_back or nil,
			connect_right = fencez.type[def.type].nodebox.connect_right or nil,
			disconnected = fencez.type[def.type].collision_box.fixed or nil,
			disconnected_sides = fencez.type[def.type].collision_box.disconnected or nil,
		},
		collision_box = {
			type = "connected",
			fixed = fencez.type[def.type].collision_box.fixed or nil,
			connect_top = fencez.type[def.type].collision_box.connect_top or nil,
			connect_bottom = fencez.type[def.type].collision_box.connect_bottom or nil,
			connect_front = fencez.type[def.type].collision_box.connect_front or nil,
			connect_left = fencez.type[def.type].collision_box.connect_left or nil,
			connect_back = fencez.type[def.type].collision_box.connect_back or nil,
			connect_right = fencez.type[def.type].collision_box.connect_right or nil,
		},
		connects_to = {"group:fence", "group:wood", "group:tree", "group:wall"},
		inventory_image = fence_texture,
		wield_image = fence_texture,
		tiles = {def.texture},
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {},
	}
	for k, v in pairs(default_fields) do
		if def[k] == nil then
			def[k] = v
		end
	end

	-- Always add to the fence group, even if no group provided
	def.groups.fence = 1
	def.groups.deco = 1
	def.groups.build = 1

	def.description = S("@1 Fence", def.description)
	def.paramtype2 = "facedir"

	def.texture = nil
	def.material = nil
	minetest.register_node(fence_name, def)
end
