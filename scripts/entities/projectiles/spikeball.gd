extends RigidBody2D

class_name Spikeball

@onready var _animation_player:= $AnimationPlayer


func _on_despawn_timer_timeout():
	_animation_player.play("despawn")


func _on_animation_player_animation_finished(anim_name):
	queue_free()
