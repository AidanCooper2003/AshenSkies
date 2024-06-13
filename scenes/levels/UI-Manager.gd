extends Node2D

@export var timerText: RichTextLabel
@export var finalTimerText: RichTextLabel
@export var healthText: RichTextLabel
@export var deathText: RichTextLabel


var time: float = 0



func _process(delta):
	if timerText != null:
		time += delta
		timerText.text = "Time: " + str(snapped(time, 0.001))

func _on_area_2d_area_entered(area):
	finalTimerText.text = "FINAL TIME: " + str(snapped(time, 0.001))


func _on_player_health_changed(newHealth: int):
	healthText.text = "Player Health: " + str(newHealth)
	if newHealth == 0:
		deathText.visible = true
