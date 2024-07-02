extends Node2D

class_name ResourceInventoryManager

signal resource_count_changed

@export var resources: Dictionary = {}

var resourcesInCrafting: Dictionary = {}

var maxResourcesInCrafting = 8

func _ready():
	initialize_inventory()

func _process(_delta):
	pass


func has_resource(resourceName: String):
	return resources.has(resourceName)


func add_resource(resourceName: String, resourceCount: int):
	if has_resource(resourceName):
		resources[resourceName] = resources[resourceName] + resourceCount
		resource_count_changed.emit(resourceName, get_resource_count(resourceName))

func subtract_resource(resourceName: String, resourceCount: int):
	if has_resource_count(resourceName, resourceCount):
		resources[resourceName] = resources[resourceName] - resourceCount
		resource_count_changed.emit(resourceName, get_resource_count(resourceName))

func has_resource_count(resourceName: String, resourceCount: int):
	if has_resource(resourceName):
		return resources[resourceName] - resourceCount >= 0
		
func add_resource_type(resourceName):
	if not has_resource(resourceName):
		resources[resourceName] = 0
		resource_count_changed.emit(resourceName, resources[resourceName])
	else:
		print("Resource already exists")

func add_resource_to_crafting(resourceName):
	if (
			has_resource(resourceName)
			and resources[resourceName] > 0 
			and get_crafting_count() < maxResourcesInCrafting
	):
		if not resourcesInCrafting.has(resourceName):
			resourcesInCrafting[resourceName] = 1
		elif resources[resourceName] - resourcesInCrafting[resourceName] > 0:
			resourcesInCrafting[resourceName] += 1
		resource_count_changed.emit(resourceName, get_resource_count(resourceName))

func subtract_resource_from_crafting(resourceName):
	if has_resource(resourceName):
		if not resourcesInCrafting.has(resourceName):
			print("Resource is not in crafting!")
		elif resourcesInCrafting[resourceName] == 1:
			resourcesInCrafting.erase(resourceName)
		else:
			resourcesInCrafting[resourceName] -= 1
		resource_count_changed.emit(resourceName, get_resource_count(resourceName))

func get_resource_count(resourceName):
	if has_resource(resourceName) and resourcesInCrafting.has(resourceName):
		return resources[resourceName] - resourcesInCrafting[resourceName]
	elif has_resource(resourceName):
		return resources[resourceName]
	else:
		return 0

func get_crafting_count():
	var total = 0
	for resourceCount in resourcesInCrafting.values():
		total += resourceCount
	return total

func reset_crafting():
	resourcesInCrafting = {}
	for resource in resources:
		resource_count_changed.emit(resource, resources[resource])
	

#Maybe have some csv for a verifier of valid resource types later?

func initialize_inventory():
	add_resource_type("cyclonium")
	add_resource_type("gun parts")
	add_resource_type("airsoft bullet")
	add_resource_type("testing fluid")
	# add_resource("gun parts", 1)
	# add_resource("cyclonium", 1)
	# add_resource("airsoft bullet", 1)
	add_resource("testing fluid", 10)
