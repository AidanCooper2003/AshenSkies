extends Node2D

class_name CraftingManager


var recipes = preload("res://recipes.csv").records
var resources = preload("res://resources.csv").records


var recipeTags: Dictionary
var recipeQualities: Dictionary
var resourceTags: Dictionary
var resourceQualities: Dictionary


# Called when the node enters the scene tree for the first time.
func _ready():
	# Removes headers from csv
	recipes.remove_at(0)
	resources.remove_at(0)
	
	print(recipes)
	print("----------------------")
	print(resources)
	
	recipeTags = getTags(recipes, 0, 1)
	resourceTags = getTags(resources, 0, 1)
	recipeQualities = getProperty(recipes, 0, 2)
	resourceQualities = getProperty(resources, 0, 2)
	
	
	craft({"gun parts": 8})
	craft({"cyclonium": 8})
	craft({"cyclonium": 4, "gun parts": 4})
	craft({"cyclonium": 6, "gun parts": 2})

	

# Situations needing to account for:
# Normal crafting
# Too many/too few ingredients
# Duplicate ingredient names (either condense or throw error?)

# ALSO heavily optimize later, this may be pretty rough for now
# Replacing item strings with item IDs could greatly help preformance

func craft(ingredients: Dictionary):
	var itemPool: Array[String]
	for ingredient in ingredients.keys():
		var ingredientCount = ingredients[ingredient]
		var ingredientTags = resourceTags.get(ingredient)
		for item in recipeTags:
			var itemTags = recipeTags.get(item)
			var sameTagCount: int
			for tag in ingredientTags:
				if itemTags.has(tag):
					sameTagCount += 1
			for i in sameTagCount:
				itemPool.append(item)
	print("----------")
	print(itemPool)
	var selectedItem = randi_range(0, itemPool.size())
	print(itemPool[selectedItem])


func getTags(collection, nameColumn, tagColumn):
	var tags: Dictionary
	for object in collection:
		var tagArray = object[1].split(", ")
		tags[object[0]] = tagArray
	return tags

func getProperty(collection, nameColumn, propertyColumn):
	var properties: Dictionary
	for object in collection:
		properties[object[nameColumn]] = object[propertyColumn]
	return properties

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
