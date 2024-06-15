extends Node2D

class_name ResourceInventoryManager

@export var resources: Dictionary = {}


func hasResource(resourceName: String):
	var resourceExists = resources.has(resourceName)
	if !resourceExists:
		print("Resource does not exist!")
	return resourceExists

func addResource(resourceName: String, resourceCount: int):
	if hasResource(resourceName):
		resources[resourceName] = resources[resourceName] + resourceCount
		print(resourceName + ": " + str(resources[resourceName]))

func subtractResource(resourceName: String, resourceCount: int):
	if hasResourceCount(resourceName, resourceCount):
		resources[resourceName] = resources[resourceName] - resourceCount
		print(resourceName + ": " + str(resources[resourceName]))

func hasResourceCount(resourceName: String, resourceCount: int):
	if hasResource(resourceName):
		return resources[resourceName] - resourceCount >= 0
