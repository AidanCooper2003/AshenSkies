class_name CraftingUIManager

extends Node2D

@export var _crafting_container: Control
@export var _resource_grid: GridContainer
@export var _crafting_grid: GridContainer
@export var _player: Player
@export var _no_texture: Texture

var _resource_textures: Dictionary
var _is_menu_open: bool = false
var _resource_containers: Dictionary
var _containers_full: bool = false

func _init() -> void:
	_resource_textures = CSVManager.get_properties(CSVManager.resources, 0, 3)


func _ready() -> void:
	_setup_signals()
	_setup_ingredient_buttons()


func _setup_ingredient_buttons() -> void:
	for button in _resource_grid.get_children():
		button.connect("pressed", _on_ingredient_clicked.bind(button))


func _setup_signals():
	EventBus.resource_count_changed.connect(_on_resource_count_changed)
	EventBus.ingredients_changed.connect(_on_ingredients_changed)
	EventBus.crafting_menu_state_changed.connect(_on_change_crafting_menu_state)


func _on_resource_count_changed(resource_name, resource_count) -> void:
	#If there isn't a resource container for the resource, assign it.
	if not _resource_containers.has(resource_name):
		for resourceContainer in _resource_grid.get_children():
			if not _resource_containers.values().has(resourceContainer):
				_resource_containers[resource_name] = resourceContainer
				_resource_containers[resource_name].get_child(0).texture = (
						load("res://sprites/resource_icons/" + _resource_textures[resource_name])
				)
				break
		#If there are no more resource containers, ignore the change.
		#This should be verified to not happen by the inventory for now.
		if not _resource_containers.has(resource_name):
			print("No more room!")
			_containers_full = true
			return
	_resource_containers[resource_name].get_child(1).text = "[right]" + str(resource_count)
	#If a resource goes down to 0 and there's no more room, unassign it.
	if resource_count == 0 and _containers_full and _resource_containers.has(resource_name):
		_resource_containers[resource_name].get_child(0).texture = _no_texture
		_resource_containers.erase(resource_name)
		_containers_full = false


func _on_ingredients_changed(ingredients: Dictionary) -> void:
	var ingredient_containers := _crafting_grid.get_children()
	var container_index := 0
	for ingredient in ingredients:
		for i in range(ingredients[ingredient]):
			ingredient_containers[container_index].icon = (
					load("res://sprites/resource_icons/" + _resource_textures[ingredient])
			)
			container_index += 1
	if container_index < 7:
		for i in range(8 - container_index):
			ingredient_containers[container_index].icon = null
			container_index += 1


func _on_change_crafting_menu_state(is_menu_open) -> void:
	_is_menu_open = is_menu_open
	_crafting_container.visible = _is_menu_open


func _on_ingredient_clicked(button) -> void:
	var button_resource = _resource_containers.find_key(button)
	if button_resource == null:
		return
	_player.add_to_crafting(button_resource)
