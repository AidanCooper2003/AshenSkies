extends Node2D

class_name ResourceInventoryManager

signal resourceCountChanged

@export var resources: Dictionary = {}

func _ready():
	initializeInventory()

func _process(_delta):
	if Input.is_action_just_pressed("DebugGainResource"):
		addResource("lost soul", 1)
		addResource("gun parts", 2)
		addResource("depleted ash", 3)
	if Input.is_action_just_pressed("DebugLoseResource"):
		subtractResource("lost soul", 1)
		subtractResource("gun parts", 2)
		subtractResource("depleted ash", 3)


func hasResource(resourceName: String):
	var resourceExists = resources.has(resourceName)
	if !resourceExists:
		print("Resource does not exist!")
	return resourceExists

func addResource(resourceName: String, resourceCount: int):
	if hasResource(resourceName):
		resources[resourceName] = resources[resourceName] + resourceCount
		print(resourceName + ": " + str(resources[resourceName]))
		resourceCountChanged.emit(resourceName, resources[resourceName])

func subtractResource(resourceName: String, resourceCount: int):
	if hasResourceCount(resourceName, resourceCount):
		resources[resourceName] = resources[resourceName] - resourceCount
		print(resourceName + ": " + str(resources[resourceName]))
		resourceCountChanged.emit(resourceName, resources[resourceName])

func hasResourceCount(resourceName: String, resourceCount: int):
	if hasResource(resourceName):
		return resources[resourceName] - resourceCount >= 0
		
func addResourceType(resourceName):
	if !hasResource(resourceName):
		resources[resourceName] = 0
		resourceCountChanged.emit(resourceName, resources[resourceName])
	else:
		print("Resource already exists")


# Maybe have some csv for a verifier later?

func initializeInventory():
	addResourceType("lost soul")
	addResourceType("depleted ash")
	addResourceType("cyclonium")
	addResourceType("gun parts")
