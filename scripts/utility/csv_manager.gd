##To call the autoload, use "CSVManager"
class_name CsvManager

extends Node

var recipes := preload("res://csv/recipes.csv").records
var resources := preload("res://csv/resources.csv").records

func _ready() -> void:
	recipes.remove_at(0)
	resources.remove_at(0)


func print_csv() -> void:
	print(recipes)
	print("----------------------")
	print(resources)
	print("----------------------")


func get_tags(collection: Array, name_column: int, tag_column: int) -> Dictionary:
	var tags: Dictionary
	for object in collection:
		var tag_array = object[tag_column].split(", ")
		tags[object[name_column]] = tag_array
	return tags


func get_properties(collection: Array, name_column: int, property_column: int) -> Dictionary:
	var properties: Dictionary
	for object in collection:
		properties[object[name_column]] = object[property_column]
	return properties


func get_property(collection: Array, name_column: int, property_column: int, objectName: String) -> Variant:
	for object in collection:
		if object[name_column] == objectName:
			return object[property_column]
	return null


func get_weapon_icon(weaponName: String) -> Variant:
	return weaponName + ".png"


func get_weapon_scene(weaponName: String) -> Variant:
	return weaponName + ".tscn"
