class_name BasicGunBullet

extends RigidBody2D

@export var knockback: float

func _on_body_entered(body) -> void:
	if knockback != 0:
		apply_knockback(body)
	queue_free()

func apply_knockback(body):
	var knockback_handler = get_node(str(body.get_path()) + "/KnockbackHandler")
	if knockback_handler:
		knockback_handler.apply_knockback(self.linear_velocity.normalized() * knockback)
