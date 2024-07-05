##To call the autoload, use "CSVManager"
class_name CsvManager

extends Node2D

var recipes := preload("res://csv/recipes.csv").records
var resources := preload("res://csv/resources.csv").records

func _ready():
	recipes.remove_at(0)
	resources.remove_at(0)


func print_csv():
	print(recipes)
	print("----------------------")
	print(resources)
	print("----------------------")


func get_tags(collection: Array, nameColumn: int, tagColumn: int) -> Dictionary:
	var tags: Dictionary
	for object in collection:
		var tagArray = object[1].split(", ")
		tags[object[0]] = tagArray
	return tags


func get_properties(collection: Array, nameColumn: int, propertyColumn: int) -> Dictionary:
	var properties: Dictionary
	for object in collection:
		properties[object[nameColumn]] = object[propertyColumn]
	return properties


func get_property(collection: Array, nameColumn: int, propertyColumn: int, objectName: String) -> Variant:
	for object in collection:
		if object[nameColumn] == objectName:
			return object[propertyColumn]
	return null


func get_item_icon(itemName: String) -> Variant:
	return get_property(recipes, 0, 4, itemName)


func get_item_scene(itemName: String) -> Variant:
	return get_property(recipes, 0, 5, itemName)
