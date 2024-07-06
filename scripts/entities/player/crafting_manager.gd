class_name CraftingManager

extends Node2D

var current_ingredients: Dictionary

var _recipe_tags: Dictionary
var _recipe_qualities: Dictionary
var _resource_tags: Dictionary
var _resource_qualities: Dictionary

func _ready() -> void:
	_recipe_tags = CSVManager.get_tags(CSVManager.recipes, 0, 1)
	_resource_tags = CSVManager.get_tags(CSVManager.resources, 0, 1)
	_recipe_qualities = CSVManager.get_properties(CSVManager.recipes, 0, 2)
	_resource_qualities = CSVManager.get_properties(CSVManager.resources, 0, 2)
	
	# _test_crafting()

#Situations needing to account for:
#Normal crafting
#Too many/too few ingredients
#Duplicate ingredient names (either condense or throw error?)

#ALSO heavily optimize later, this may be pretty rough for now
#Replacing weapon strings with weapon IDs could greatly help preformance
#Also, since there are so many duplicate entries, maybe there could be
#a set of ranges that the random number chosen will be tested to see where it falls

func craft(ingredients: Dictionary) -> String:
	var weapon_pool: Array[String]
	var tag_counts := _get_ingredients_tags(ingredients)

	for weapon in _recipe_tags:
		for i in _get_tag_match_count(weapon, tag_counts):
			weapon_pool.append(weapon)
	var chosen_weapon := randi_range(0, weapon_pool.size() - 1)
	return weapon_pool[chosen_weapon]

func _test_crafting() -> void:
	print("Only Gun Tags")
	print("----------")
	for i in 10:
		print(craft({"gun parts": 8}))
	print("Only Air Tags")
	print("----------")
	for i in 10:
		print(craft({"cyclonium": 8}))
	print("Equal part air and gun tags")
	print("----------")
	for i in 10:
		print(craft({"cyclonium": 4, "gun parts": 4}))
	print("More air than gun tags")
	print("----------")
	for i in 10:
		print(craft({"cyclonium": 6, "gun parts": 2}))


func _get_tag_match_count(weapon: String, tag_counts: Dictionary) -> int:
	var weapon_tags = _recipe_tags[weapon]
	var weapon_count := 0
	for tag in weapon_tags:
		if not tag_counts.has(tag):
			return 0 # If your ingredients don't contain every tag in the weapon, the weapon can't be added
		weapon_count += tag_counts[tag]
	return weapon_count


#Combine tags, turn negative tags into max 0 (or even prevent defaults?)
func _ingredient_tags_processing():
	pass


#Loop through all ingredients, and add each tag they have multiplied by the ingredient count.
func _get_ingredients_tags(ingredients: Dictionary) -> Dictionary:
	var tag_counts: Dictionary
	for ingredient in ingredients:
		var ingredient_tags = _resource_tags.get(ingredient)
		for tag in ingredient_tags:
			if tag_counts.has(tag):
				tag_counts[tag] = tag_counts[tag] + ingredients[ingredient]
			else:
				tag_counts[tag] = ingredients[ingredient]
	return tag_counts
