class_name BasicGunBullet

extends RigidBody2D

func _on_body_entered(body) -> void:
	queue_free()
