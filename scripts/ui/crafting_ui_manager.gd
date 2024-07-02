extends Node2D

class_name CraftingUIManager

@export var craftingContainer: Control
@export var resourceGrid: GridContainer
@export var craftingGrid: GridContainer
@export var player: Player

@export var noTexture: Texture



var resourceTextures: Dictionary

var isMenuOpen: bool = false

var resourceContainers: Dictionary

var containersFull: bool = false

func _init():
	resourceTextures = CSVManager.get_properties(CSVManager.resources, 0, 3)

func _ready():
	setup_ingredient_buttons()


func _on_player_change_crafting_menu_state(isMenuOpen):
	self.isMenuOpen = isMenuOpen
	craftingContainer.visible = isMenuOpen


func _on_player_resource_count_changed(resourceName, resourceCount):
	# If there isn't a resource container for the resource, assign it.
	if !resourceContainers.has(resourceName):
		for resourceContainer in resourceGrid.get_children():
			if !resourceContainers.values().has(resourceContainer):
				resourceContainers[resourceName] = resourceContainer
				print(resourceTextures.keys())
				resourceContainers[resourceName].get_child(0).texture = load("res://sprites/resource_icons/" + resourceTextures[resourceName])
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
		resourceContainers[resourceName].get_child(0).texture = noTexture
		resourceContainers.erase(resourceName)
		containersFull = false

func _on_ingredients_changed(ingredients: Dictionary):
	var ingredientContainers = craftingGrid.get_children()
	var containerIndex = 0
	for ingredient in ingredients:
		for i in range(ingredients[ingredient]):
			ingredientContainers[containerIndex].icon = load("res://sprites/resource_icons/" + resourceTextures[ingredient])
			containerIndex += 1
	if containerIndex < 7:
		for i in range(8 - containerIndex):
			ingredientContainers[containerIndex].icon = null
			containerIndex += 1

func setup_ingredient_buttons():
	for button in resourceGrid.get_children():
		button.connect("pressed", on_ingredient_clicked.bind(button))

func on_ingredient_clicked(button):
	var buttonResource = resourceContainers.find_key(button)
	if buttonResource == null:
		return
	player.add_to_crafting(buttonResource)
