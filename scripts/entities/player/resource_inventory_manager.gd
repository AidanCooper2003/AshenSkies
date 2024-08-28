class_name ResourceInventoryManager

extends Node2D

var max_ingredients = 4


@export var resources: Dictionary = {}
@export var max_resources: int

var ingredients: Dictionary = {}

func _ready() -> void:
	EventBus.ingredient_selected.connect(increment_ingredient)
	EventBus.ingredient_deselected.connect(decrement_ingredient)
	EventBus.ingredients_reset.connect(reset_ingredients)
	EventBus.resource_added.connect(add_resource)
	EventBus.resource_subtracted.connect(subtract_resource)
	self.call_deferred("_initialize_inventory")

func has_resource(resource_name: String) -> bool:
	return resources.has(resource_name)


func add_resource(resource_name: String, resource_count: int) -> void:
	if max_resources > resources.size() && !has_resource(resource_name):
		add_resource_type(resource_name)
	if has_resource(resource_name):
		resources[resource_name] += resource_count
		_update_resource(resource_name)


func subtract_resource(resource_name: String, resource_count: int) -> void:
	if has_resource_count(resource_name, resource_count):
		resources[resource_name] -= resource_count
		_update_resource(resource_name)


func subtract_resources(resources: Dictionary) -> void:
	for resource in resources:
		var resource_count = resources[resource]
		if has_resource_count(resource, resource_count):
			self.resources[resource] -= resource_count
			_update_resource(resource)

func has_resource_count(resource_name: String, resource_count: int) -> bool:
	if has_resource(resource_name):
		return resources[resource_name] - resource_count >= 0
	return false


func add_resource_type(resource_name: String) -> void:
	if not has_resource(resource_name):
		resources[resource_name] = 0
		_update_resource(resource_name)
	else:
		print("Resource already exists")


func increment_ingredient(resource_name: String) -> void:
	if (
			has_resource(resource_name)
			and resources[resource_name] > 0 
			and get_ingredient_count() < max_ingredients
	):
		if not ingredients.has(resource_name):
			ingredients[resource_name] = 1
		elif resources[resource_name] - ingredients[resource_name] > 0:
			ingredients[resource_name] += 1
		_update_resource(resource_name)


func decrement_ingredient(resource_name: String) -> void:
	if has_resource(resource_name):
		if not ingredients.has(resource_name):
			print("Resource is not in crafting!")
		elif ingredients[resource_name] == 1:
			ingredients.erase(resource_name)
		else:
			ingredients[resource_name] -= 1
		_update_resource(resource_name)


func get_resource_count(resource_name: String) -> int:
	if has_resource(resource_name) and ingredients.has(resource_name):
		return resources[resource_name] - ingredients[resource_name]
	elif has_resource(resource_name):
		return resources[resource_name]
	else:
		return 0


func get_ingredient_count() -> int:
	var total = 0
	for ingredient_count in ingredients.values():
		total += ingredient_count
	return total


func reset_ingredients() -> void:
	ingredients = {}
	_update_all_resources()


func _update_all_resources() -> void:
	for resource_name in resources:
		_update_resource(resource_name)


func _update_resource(resource_name: String) -> void:
	EventBus.resource_count_changed.emit(resource_name, get_resource_count(resource_name))
	EventBus.ingredients_changed.emit(ingredients)


#Maybe have some csv for a verifier of valid resource types later?
func _initialize_inventory() -> void:
	add_resource("projectile_essence", 6)
