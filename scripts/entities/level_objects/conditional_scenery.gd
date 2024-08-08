class_name ConditionalScenery

extends StaticBody2D

@export var trigger_conditions: Array

@onready var _health_component := $HealthComponent
@onready var _animation_player := $AnimationPlayer

func _on_condition_handler_condition_added(condition_name):
	if condition_name in trigger_conditions:
		_start_destruction()

func _start_destruction():
	_animation_player.play("burning")




func _on_animation_player_animation_finished(anim_name):
	queue_free()
