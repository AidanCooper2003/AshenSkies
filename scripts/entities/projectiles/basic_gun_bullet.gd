class_name BasicGunBullet

extends RigidBody2D

func _on_body_entered(_body) -> void:
	queue_free()
