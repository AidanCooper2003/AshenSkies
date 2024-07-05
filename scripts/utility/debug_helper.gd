class_name DebugHelper

extends Node2D

@export var _player: Player
@export var _ui_manager: UIManager

var _time: float = 0.0

func _process(_delta):
	if Input.is_action_pressed("Debug 1"):
		get_tree().change_scene_to_file("res://scenes/levels/playtest_level.tscn")
	if Input.is_action_just_pressed("Debug 3"):
		_player.start_crafting()
	if Input.is_action_just_pressed("Debug 2"):
		_player.reset_ingredients()
	if Input.is_action_just_pressed("Debug 4"):
		var nothing = ""
		_ui_manager._on_player_weapon_slot_changed(1, nothing)
