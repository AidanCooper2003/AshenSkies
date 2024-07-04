class_name ResourceInventoryManager

extends Node2D

signal resource_count_changed

const MAX_INGREDIENTS = 8

@export var resources: Dictionary = {}

var ingredients: Dictionary = {}

func _ready():
	_initialize_inventory()


func has_resource(resource_name: String):
	return resources.has(resource_name)


func add_resource(resource_name: String, resource_count: int):
	if has_resource(resource_name):
		resources[resource_name] += resource_count
		_update_resource(resource_name)


func subtract_resource(resource_name: String, resource_count: int):
	if has_resource_count(resource_name, resource_count):
		resources[resource_name] -= resource_count
		_update_resource(resource_name)


func has_resource_count(resource_name: String, resource_count: int):
	if has_resource(resource_name):
		return resources[resource_name] - resource_count >= 0


func add_resource_type(resource_name):
	if not has_resource(resource_name):
		resources[resource_name] = 0
		_update_resource(resource_name)
	else:
		print("Resource already exists")


func increment_ingredient(resource_name):
	if (
			has_resource(resource_name)
			and resources[resource_name] > 0 
			and get_ingredient_count() < MAX_INGREDIENTS
	):
		if not ingredients.has(resource_name):
			ingredients[resource_name] = 1
		elif resources[resource_name] - ingredients[resource_name] > 0:
			ingredients[resource_name] += 1
		_update_resource(resource_name)


func decrement_ingredient(resource_name):
	if has_resource(resource_name):
		if not ingredients.has(resource_name):
			print("Resource is not in crafting!")
		elif ingredients[resource_name] == 1:
			ingredients.erase(resource_name)
		else:
			ingredients[resource_name] -= 1
		_update_resource(resource_name)


func get_resource_count(resource_name):
	if has_resource(resource_name) and ingredients.has(resource_name):
		return resources[resource_name] - ingredients[resource_name]
	elif has_resource(resource_name):
		return resources[resource_name]
	else:
		return 0


func get_ingredient_count():
	var total = 0
	for ingredient_count in ingredients.values():
		total += ingredient_count
	return total


func reset_ingredients():
	ingredients = {}
	_update_all_resources()


func _update_all_resources():
	for resource_name in resources:
		_update_resource(resource_name)


func _update_resource(resource_name: String):
	resource_count_changed.emit(resource_name, get_resource_count(resource_name))


#Maybe have some csv for a verifier of valid resource types later?
func _initialize_inventory():
	add_resource_type("cyclonium")
	add_resource_type("gun parts")
	add_resource_type("airsoft bullet")
	add_resource_type("testing fluid")
	# add_resource("gun parts", 1)
	# add_resource("cyclonium", 1)
	# add_resource("airsoft bullet", 1)
	add_resource("testing fluid", 10)
