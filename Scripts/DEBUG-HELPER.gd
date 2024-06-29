extends Node2D

@export var timerText: RichTextLabel
@export var finalTimerText: RichTextLabel
@export var healthText: RichTextLabel
@export var deathText: RichTextLabel
@export var player: Player

var time: float = 0



func _process(delta):
	#if Input.is_action_pressed("Debug Reset"):
	#	get_tree().change_scene_to_file("res://scenes/levels/playtest_level.tscn")

	if Input.is_action_pressed("Debug 1"):
		get_tree().change_scene_to_file("res://scenes/levels/scene.tscn")

	if Input.is_action_just_pressed("Debug 3"):
		player.startCrafting()

