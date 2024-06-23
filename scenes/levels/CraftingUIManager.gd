extends Node2D

class_name CraftingUIManager

@export var craftingContainer: Control
@export var resourceGrid: GridContainer

var isMenuOpen: bool = false

var resourceContainers: Dictionary

var containersFull: bool = false

func _on_player_change_crafting_menu_state(isMenuOpen):
	self.isMenuOpen = isMenuOpen
	craftingContainer.visible = isMenuOpen


func _on_player_resource_count_changed(resourceName, resourceCount):
	# If there isn't a resource container for the resource, assign it.
	if !resourceContainers.has(resourceName):
		for resourceContainer in resourceGrid.get_children():
			if !resourceContainers.values().has(resourceContainer):
				resourceContainers[resourceName] = resourceContainer
				break
		# If there are no more resource containers, ignore the change.
		# This should be verified to not happen by the inventory for now.
		if !resourceContainers.has(resourceName):
			print("No more room!")
			containersFull = true
			return
	resourceContainers[resourceName].get_child(1).text = "[right]" + str(resourceCount)
	# If a resource goes down to 0 and there's no more room, unassign it.
	if resourceCount == 0 && containersFull && resourceContainers.has(resourceName):
		resourceContainers.erase(resourceName)
		containersFull = false
