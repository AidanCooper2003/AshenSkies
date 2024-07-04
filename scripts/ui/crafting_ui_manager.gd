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


func _on_player_resource_count_changed(resource_name, resource_count):
	#If there isn't a resource container for the resource, assign it.
	if not resourceContainers.has(resource_name):
		for resourceContainer in resourceGrid.get_children():
			if not resourceContainers.values().has(resourceContainer):
				resourceContainers[resource_name] = resourceContainer
				resourceContainers[resource_name].get_child(0).texture = (
						load("res://sprites/resource_icons/" + resourceTextures[resource_name])
				)
				break
		#If there are no more resource containers, ignore the change.
		#This should be verified to not happen by the inventory for now.
		if not resourceContainers.has(resource_name):
			print("No more room!")
			containersFull = true
			return
	resourceContainers[resource_name].get_child(1).text = "[right]" + str(resource_count)
	#If a resource goes down to 0 and there's no more room, unassign it.
	if resource_count == 0 and containersFull and resourceContainers.has(resource_name):
		resourceContainers[resource_name].get_child(0).texture = noTexture
		resourceContainers.erase(resource_name)
		containersFull = false

func _on_ingredients_changed(ingredients: Dictionary):
	var ingredientContainers = craftingGrid.get_children()
	var containerIndex = 0
	for ingredient in ingredients:
		for i in range(ingredients[ingredient]):
			ingredientContainers[containerIndex].icon = (
					load("res://sprites/resource_icons/" + resourceTextures[ingredient])
			)
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
