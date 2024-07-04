extends Node2D

@export var timerText: RichTextLabel
@export var finalTimerText: RichTextLabel
@export var healthText: RichTextLabel
@export var deathText: RichTextLabel
@export var _player: Player
@export var uiManager: UIManager

var time: float = 0.0



func _process(delta):
	# if Input.is_action_pressed("Debug Reset"):
	# get_tree().change_scene_to_file("res://scenes/levels/playtest_level.tscn")

	if Input.is_action_pressed("Debug 1"):
		get_tree().change_scene_to_file("res://scenes/levels/playtest_level.tscn")

	if Input.is_action_just_pressed("Debug 3"):
		_player.start_crafting()
		
	if Input.is_action_just_pressed("Debug 2"):
		_player.reset_ingredients()
		
	if Input.is_action_just_pressed("Debug 4"):
		var nothing = ""
		uiManager._on_player_weapon_slot_changed(1, nothing)

