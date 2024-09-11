class_name Mine

extends RigidBody2D

@onready var _animation_player := $AnimationPlayer

func _ready():
	if $DamageDealerComponent:
		$DamageDealerComponent.final_pierce_reached.connect(queue_free)

func _on_despawn_timer_timeout() -> void:
	_animation_player.play("despawn")


func _on_animation_player_animation_finished(_anim_name) -> void:
	queue_free()
