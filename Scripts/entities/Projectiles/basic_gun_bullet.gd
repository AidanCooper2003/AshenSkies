extends RigidBody2D

class_name BasicGunBullet

func _on_body_entered(body):
	queue_free()
