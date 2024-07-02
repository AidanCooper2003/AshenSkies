extends Node2D


var recipes = preload("res://csv/recipes.csv").records
var resources = preload("res://csv/resources.csv").records

# Later this should use dictionaries to cache everything

func _ready():
	recipes.remove_at(0)
	resources.remove_at(0)
	print(CSVManager.recipes)
	print("----------------------")
	print(CSVManager.resources)
	print("----------------------")

func getTags(collection, nameColumn, tagColumn):
	var tags: Dictionary
	for object in collection:
		var tagArray = object[1].split(", ")
		tags[object[0]] = tagArray
	return tags

func getProperties(collection, nameColumn, propertyColumn):
	var properties: Dictionary
	for object in collection:
		properties[object[nameColumn]] = object[propertyColumn]
	return properties
	

func getProperty(collection, nameColumn, propertyColumn, objectName):
	for object in collection:
		if object[nameColumn] == objectName:
			return object[propertyColumn]
	return null


func getItemIcon(itemName):
	return getProperty(recipes, 0, 4, itemName)

func getItemScene(itemName):
	return getProperty(recipes, 0, 5, itemName)
