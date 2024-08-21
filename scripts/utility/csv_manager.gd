##To call the autoload, use "CSVManager"
class_name CsvManager

extends Node

var recipes := preload("res://csv/recipes.csv").records
var resources := preload("res://csv/resources.csv").records
var conditions := preload("res://csv/conditions.csv").records
var tags := preload("res://csv/tags.csv").records

var _max_modifications = 5

func _ready() -> void:
	recipes.remove_at(0)
	resources.remove_at(0)
	conditions.remove_at(0)


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


func get_weapon_names() -> Array:
	return _get_names(recipes, 0)


func get_resource_names() -> Array:
	return _get_names(resources, 0)


func get_types_of_resources() -> Dictionary:
	var resource_types = get_properties(resources, 0, 3)
	var types_of_resources := {}
	for resource in resource_types:
		var type = resource_types[resource]
		if !types_of_resources.has(type):
			types_of_resources[type] = [resource]
		else:
			types_of_resources[type].append(resource)
	return types_of_resources


func get_tag_type(tag_name: String) -> String:
	return get_property(tags, 0, 1, tag_name)


func get_tag_types() -> Dictionary:
	return get_properties(tags, 0, 1)



func get_condition_modifications(condition_name: String) -> Dictionary:
	var condition := {}
	for i in range(1, _max_modifications + 1):
		var modification_name = get_property(conditions, 0, i * 2 - 1, condition_name)
		if modification_name == "" || modification_name == null:
			return condition
		var modification_amount = get_property(conditions, 0, i * 2, condition_name) as float
		condition[modification_name] = modification_amount
	return condition


func _get_names(collection: Array, name_column) -> Array:
	var names: Array
	for object in collection:
		names.append(object[name_column])
	return names
