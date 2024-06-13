extends RigidBody2D

class_name Spikeball

@export var animationPlayer: AnimationPlayer


func _on_despawn_timer_timeout():
	animationPlayer.play("despawn")


func _on_animation_player_animation_finished(anim_name):
	queue_free()
