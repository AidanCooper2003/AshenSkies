extends Node2D

@export var timerText: RichTextLabel
@export var finalTimerText: RichTextLabel
@export var healthText: RichTextLabel
@export var deathText: RichTextLabel

var time: float = 0



func _process(delta):
	if Input.is_action_pressed("Debug Reset"):
		get_tree().change_scene_to_file("res://scenes/levels/playtest_level.tscn")

	if Input.is_action_pressed("Debug 1"):
		get_tree().change_scene_to_file("res://scenes/levels/scene.tscn")
	if timerText != null:
		time += delta
		timerText.text = "Time: " + str(snapped(time, 0.01))


func _on_area_2d_area_entered(area):
	finalTimerText.text = "FINAL TIME: " + str(snapped(time, 0.01))


func _on_player_health_changed(newHealth: int):
	healthText.text = "Player Health: " + str(newHealth)
	if newHealth == 0:
		deathText.visible = true
