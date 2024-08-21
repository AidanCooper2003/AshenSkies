class_name CraftingManager

extends Node2D

var current_ingredients: Dictionary

var _recipe_tags: Dictionary
var _recipe_qualities: Dictionary
var _resource_tags: Dictionary
var _resource_qualities: Dictionary
var _tag_types: Dictionary

func _ready() -> void:
	_recipe_tags = CSVManager.get_tags(CSVManager.recipes, 0, 1)
	_resource_tags = CSVManager.get_tags(CSVManager.resources, 0, 1)
	_recipe_qualities = CSVManager.get_properties(CSVManager.recipes, 0, 2)
	_resource_qualities = CSVManager.get_properties(CSVManager.resources, 0, 2)
	_tag_types = CSVManager.get_tag_types()
	
	
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
	
	#If tags don't contain form tags, add one of each
	var has_form_tag := false
	for tag in tag_counts:
		if _tag_types[tag] == "Form":
			has_form_tag = true
			break
	if !has_form_tag:
		for tag in _tag_types:
			if _tag_types[tag] == "Form":
				tag_counts[tag] = 1
	
	#Loop through each recipe, and add the weapon for each tag match as long as all element tags are present
	for weapon in _recipe_tags:
		for i in _get_tag_match_count(weapon, tag_counts):
			weapon_pool.append(weapon)
	print(tag_counts)
	print(weapon_pool)
	#TODO Further away weapon quality is from crafting quality, higher chance to reroll and remove from pool.
	#This may require some testing to ensure it doesn't cause an infinite loop of not choosing weapons
	#If items run out, maybe reget item pool and pick totally randomly?
	#Or make sure numbers work in such a way where you're always guaranteed to have at least one item that will not have a roll done.
	
	var quality := 0
	for ingredient in ingredients:
		quality += _resource_qualities[ingredient]
	print(quality)
	
	
	var chosen_weapon := randi_range(0, weapon_pool.size() - 1)
	if weapon_pool.size() > 0:
		return weapon_pool[chosen_weapon]
	else:
		return "test_gun"

func _test_crafting() -> void:
	pass


func _get_tag_match_count(weapon: String, tag_counts: Dictionary) -> int:
	var weapon_tags = _recipe_tags[weapon]
	var weapon_count := 0
	for tag in weapon_tags:
		if _tag_types[tag] != "Mechanic" && not tag_counts.has(tag):
			return 0 # If your ingredients don't contain every non-mechanical tag in the weapon, the weapon can't be added
		if _tag_types[tag] == "Mechanic" && !tag_counts.has(tag):
			tag_counts[tag] = 0
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
