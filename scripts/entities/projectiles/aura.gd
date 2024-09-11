class_name Aura

extends Node2D

var connected_condition: String

func _ready():
	if $AnimationPlayer:
		$AnimationPlayer.play("start_aura")

func end_aura(condition):
	if condition == connected_condition:
		queue_free()
