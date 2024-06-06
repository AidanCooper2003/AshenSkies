extends Node2D


func _process(delta):
	if Input.is_action_pressed("Debug Reset"):
		get_tree().change_scene_to_file("res://playtest_level.tscn")
