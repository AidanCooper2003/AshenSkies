extends Node2D

class_name ResourceInventoryManager

signal resourceCountChanged

@export var resources: Dictionary = {}

var resourcesInCrafting: Dictionary = {}

var maxResourcesInCrafting = 8

func _ready():
	initializeInventory()

func _process(_delta):
	pass


func hasResource(resourceName: String):
	return resources.has(resourceName)


func addResource(resourceName: String, resourceCount: int):
	if hasResource(resourceName):
		resources[resourceName] = resources[resourceName] + resourceCount
		print(resourceName + ": " + str(resources[resourceName]))
		resourceCountChanged.emit(resourceName, getResourceCount(resourceName))

func subtractResource(resourceName: String, resourceCount: int):
	if hasResourceCount(resourceName, resourceCount):
		resources[resourceName] = resources[resourceName] - resourceCount
		print(resourceName + ": " + str(resources[resourceName]))
		resourceCountChanged.emit(resourceName, getResourceCount(resourceName))

func hasResourceCount(resourceName: String, resourceCount: int):
	if hasResource(resourceName):
		return resources[resourceName] - resourceCount >= 0
		
func addResourceType(resourceName):
	if !hasResource(resourceName):
		resources[resourceName] = 0
		resourceCountChanged.emit(resourceName, resources[resourceName])
	else:
		print("Resource already exists")

func addResourceToCrafting(resourceName):
	if hasResource(resourceName) && resources[resourceName] > 0 && getCraftingCount() < maxResourcesInCrafting:
		if !resourcesInCrafting.has(resourceName):
			resourcesInCrafting[resourceName] = 1
		elif resources[resourceName] - resourcesInCrafting[resourceName] > 0:
			resourcesInCrafting[resourceName] += 1
		resourceCountChanged.emit(resourceName, getResourceCount(resourceName))

func subtractResourceFromCrafting(resourceName):
	if hasResource(resourceName):
		if !resourcesInCrafting.has(resourceName):
			print("Resource is not in crafting!")
		elif resourcesInCrafting[resourceName] == 1:
			resourcesInCrafting.erase(resourceName)
		else:
			resourcesInCrafting[resourceName] -= 1
		resourceCountChanged.emit(resourceName, getResourceCount(resourceName))

func getResourceCount(resourceName):
	if hasResource(resourceName) && resourcesInCrafting.has(resourceName):
		return resources[resourceName] - resourcesInCrafting[resourceName]
	elif hasResource(resourceName):
		return resources[resourceName]
	else:
		return 0

func getCraftingCount():
	var total = 0
	for resourceCount in resourcesInCrafting.values():
		total += resourceCount
	return total

func resetCrafting():
	resourcesInCrafting = {}
	for resource in resources:
		resourceCountChanged.emit(resource, resources[resource])
	

# Maybe have some csv for a verifier of valid resource types later?

func initializeInventory():
	addResourceType("cyclonium")
	addResourceType("gun parts")
	addResourceType("airsoft bullet")
	addResourceType("testing fluid")
	#addResource("gun parts", 1)
	#addResource("cyclonium", 1)
	#addResource("airsoft bullet", 1)
	addResource("testing fluid", 10)
