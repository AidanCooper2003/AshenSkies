extends RigidBody2D

class_name BasicGunBullet

func _on_body_entered(body):
	print("goodbye bullet")
	queue_free()
