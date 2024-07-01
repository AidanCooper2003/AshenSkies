extends Node2D


var recipes = preload("res://recipes.csv").records
var resources = preload("res://resources.csv").records


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

func getProperty(collection, nameColumn, propertyColumn):
	var properties: Dictionary
	for object in collection:
		properties[object[nameColumn]] = object[propertyColumn]
	return properties
