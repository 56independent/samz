local S, modname = ...

function foodz.register_food(name, def)

	local food_name = modname..":"..name

	def.groups.food = def.hp or 2
	def.groups.hunger = def.hunger or 2

	if def.type == "craft" then
		minetest.register_craftitem(food_name, {
			description = S(def.description),
			inventory_image = def.inventory_image,
			wield_image = def.wield_image or def.inventory_image,
			groups = def.groups,
			on_use = function(itemstack, user, pointed_thing)
				eatz.item_eat(itemstack, user, food_name)
				return itemstack
			end
		})
	else
		local mesh, selection_box, node_box
		if def.type == "nodebox" then
			mesh = nil
			node_box = {
				type = "fixed",
				fixed = def.node_box,
			}
			selection_box = {
				type = "fixed",
				fixed = def.selection_box,
			}
		else
			node_box = nil
			selection_box = nil
			mesh = "foodz_pumpkin_cake.obj"
		end
		minetest.register_node(food_name, {
			inventory_image = def.inventory_image,
			drawtype = def.type,
			description = S(def.description),
			mesh = mesh,
			node_box = node_box,
			selection_box = selection_box,
			tiles = def.tiles,
			use_texture_alpha = true,
			paramtype2 = "facedir",
			groups = def.groups,

			on_use = function(itemstack, user, pointed_thing)
				eatz.item_eat(itemstack, user, food_name)
				return itemstack
			end
		})
	end

	if def.recipe then
		minetest.register_craft({
			type = def.recipe.type,
			output = food_name .. " " ..(def.recipe.output_amount or 1),
			recipe = def.recipe.items,
			cooktime = def.recipe.cooktime or 1,
		})
	end
end

