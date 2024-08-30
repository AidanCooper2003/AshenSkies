class_name DebugHelper

extends Node2D

@export var _player: Player
@export var _ui_manager: UIManager

var _time: float = 0.0

func _ready() -> void:
	pass

func _process(_delta) -> void:
	if Input.is_action_pressed("Debug 1"):
		EventBus.level_changed.emit()
		get_tree().change_scene_to_file("res://scenes/levels/game.tscn")
	if Input.is_action_just_pressed("Debug 3"):
		EventBus.crafting_started.emit()
	if Input.is_action_just_pressed("Debug 2"):
		EventBus.ingredients_reset.emit()
	if Input.is_action_just_pressed("Debug 4"):
		_assign_weapon("hastemaker")
		_assign_weapon("caffeination_station")
		_assign_weapon("terminal_lucidity")
	if Input.is_action_just_pressed("Exit To Menu"):
		get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")


func _assign_weapon(weapon: String) -> void:
	var weapon_scene = CSVManager.get_weapon_scene(weapon)
	if weapon_scene != null:
		_player._weapon_inventory_manager.add_weapon(weapon_scene)
	EventBus.weapon_in_slot_changed.emit(_player._weapon_inventory_manager.weapons.size() - 1, weapon)
