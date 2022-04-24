S, modname = ...

function foodz.register_food(name, def)
	def.groups.food = 1
	local food_name = modname..":"..name

	if def.type == "craft" then
		minetest.register_craftitem(food_name, {
			description = S(def.description),
			inventory_image = def.inventory_image,
			wield_image = def.wield_image or def.inventory_image,
			groups = def.groups,
			on_use = function(itemstack, user, pointed_thing)
				eatz.item_eat(itemstack, user, food_name, def.hp or 1, def.hunger or 2)
				return itemstack
			end
		})
	else
		minetest.register_node(food_name, {
			inventory_image = def.inventory_image,
			drawtype = "nodebox",
			description = S(def.description),
			tiles = def.tiles,
			paramtype = "light",
			paramtype2 = "facedir",
			node_box = {
				type = "fixed",
				fixed = def.node_box,
			},
			selection_box = {
				type = "fixed",
				fixed = def.selection_box,
			},
			groups = def.groups,

			on_use = function(itemstack, user, pointed_thing)
				eatz.item_eat(itemstack, user, food_name, def.hp or 1, def.hunger or 2)
				return itemstack
			end
		})
	end

	minetest.register_craft({
		type = "shapeless",
		output = food_name,
		recipe = def.recipe,
	})
end

