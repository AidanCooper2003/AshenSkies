extends Node2D

class_name CraftingManager




var recipeTags: Dictionary
var recipeQualities: Dictionary
var resourceTags: Dictionary
var resourceQualities: Dictionary

var currentIngredients: Dictionary


#Called when the node enters the scene tree for the first time.
func _ready():

	

	recipeTags = CSVManager.get_tags(CSVManager.recipes, 0, 1)
	resourceTags = CSVManager.get_tags(CSVManager.resources, 0, 1)
	recipeQualities = CSVManager.get_properties(CSVManager.recipes, 0, 2)
	resourceQualities = CSVManager.get_properties(CSVManager.resources, 0, 2)
	
	# test_crafting()



func test_crafting():
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

#Situations needing to account for:
#Normal crafting
#Too many/too few ingredients
#Duplicate ingredient names (either condense or throw error?)

#ALSO heavily optimize later, this may be pretty rough for now
#Replacing item strings with item IDs could greatly help preformance
#Also, since there are so many duplicate entries, maybe there could be
#a set of ranges that the random number chosen will be tested to see where it falls

func craft(ingredients: Dictionary):
	var itemPool: Array[String]
	var tagCounts: Dictionary = get_ingredients_tags(ingredients)

	for item in recipeTags:
		for i in get_tag_match_count(item, tagCounts):
			itemPool.append(item)
	var chosenItem = randi_range(0, itemPool.size() - 1)
	return itemPool[chosenItem]


func get_tag_match_count(item: String, tagCounts: Dictionary):
	var itemTags = recipeTags[item]
	var itemCount = 0
	for tag in itemTags:
		if not tagCounts.has(tag):
			return 0 # If your ingredients don't contain every tag in the item, the item can't be added
		itemCount += tagCounts[tag]
	return itemCount



#Combine tags, turn negative tags into max 0 (or even prevent defaults?)
func ingredient_tags_processing():
	pass




#Loop through all ingredients, and add each tag they have multiplied by the ingredient count.
func get_ingredients_tags(ingredients: Dictionary):
	var tagCounts: Dictionary
	for ingredient in ingredients:
		var ingredientTags = resourceTags.get(ingredient)
		for tag in ingredientTags:
			if tagCounts.has(tag):
				tagCounts[tag] = tagCounts[tag] + ingredients[ingredient]
			else:
				tagCounts[tag] = ingredients[ingredient]
	return tagCounts
