class_name CraftingManager

extends Node2D

var current_ingredients: Dictionary

var _recipe_tags: Dictionary
var _recipe_qualities: Dictionary
var _resource_tags: Dictionary
var _resource_qualities: Dictionary
var _tag_types: Dictionary
var _quality_weights: Dictionary

func _ready() -> void:
	_recipe_tags = CSVManager.get_tags(CSVManager.recipes, 0, 1)
	_resource_tags = CSVManager.get_tags(CSVManager.resources, 0, 1)
	_recipe_qualities = CSVManager.get_properties(CSVManager.recipes, 0, 2)
	_resource_qualities = CSVManager.get_properties(CSVManager.resources, 0, 2)
	_tag_types = CSVManager.get_tag_types()
	_initialize_quality_weights()

	
	
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
	var ingredients_quality := _get_ingredients_quality(ingredients)
	
	for ingredient in ingredients:
		if ingredient == "projectile_essence" && ingredients[ingredient] == 4:
			return "test_gun"
	
	
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
	
	var item_quality = _choose_quality(ingredients_quality)
	
	#Loop through each recipe, and add the weapon for each tag match as long as 
	#all element tags are present
	#and the quality matches the chosen item quality
	for weapon in _recipe_tags:
		for i in _get_tag_match_count(weapon, tag_counts):
			if _recipe_qualities[weapon] == item_quality:
				weapon_pool.append(weapon)
				
	
	if weapon_pool.is_empty():
		print("No weapons of that quality and tags! Now trying +- 1")
		for weapon in _recipe_tags:
			for i in _get_tag_match_count(weapon, tag_counts):
				if _recipe_qualities[weapon] <= item_quality + 1 && _recipe_qualities[weapon] >= item_quality - 1:
					weapon_pool.append(weapon)

	#If there are no weapons that match that tag with that quality, run again but 
	#this time don't check for
	#quality.
	if weapon_pool.is_empty():
		print("No weapons of that quality and tags! All bets are off!")
		for weapon in _recipe_tags:
			for i in _get_tag_match_count(weapon, tag_counts):
				weapon_pool.append(weapon)

	print("Tags")
	print(tag_counts)
	print("Pool")
	print(weapon_pool)
	print("Ingredients Quality")
	print(ingredients_quality)
	print("Chosen Quality")
	print(item_quality)
	#TODO Further away weapon quality is from crafting quality, higher chance to reroll and remove from pool.
	#This may require some testing to ensure it doesn't cause an infinite loop of not choosing weapons
	#If items run out, maybe reget item pool and pick totally randomly?
	#Or make sure numbers work in such a way where you're always guaranteed to have at least one item that will not have a roll done.
	
	
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

func _get_ingredients_quality(ingredients: Dictionary) -> int:
	var quality := 0
	for ingredient in ingredients:
		quality += _resource_qualities[ingredient] * ingredients[ingredient]
	return quality

func _choose_quality(quality: int) -> int:
	quality = clampi(quality, 0, 11)
	var weights: Array = _quality_weights[quality]
	var weight_total = weights.reduce(_sum, 0)
	var choice = randf_range(0, weight_total)
	for i in range(_quality_weights.size()):
		choice -= _quality_weights[quality][i]
		if choice <= 0:
			return i + 1
	return 1
	
func _sum(accumulator, number):
	return accumulator + number

func _initialize_quality_weights() -> void:
	_quality_weights[0] = [1, 0, 0]
	_quality_weights[1] = [6, 1, 0]
	_quality_weights[2] = [3, 1, 0]
	_quality_weights[3] = [2, 1, 0]
	_quality_weights[4] = [1, 1, 0]
	_quality_weights[5] = [1, 2, 0]
	_quality_weights[6] = [0, 1, 0]
	_quality_weights[7] = [0, 6, 1]
	_quality_weights[8] = [0, 3, 1]
	_quality_weights[9] = [0, 1, 1]
	_quality_weights[10] = [0, 1, 2]
	_quality_weights[11] = [0, 0, 1]
