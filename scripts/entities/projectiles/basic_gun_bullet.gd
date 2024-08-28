class_name BasicGunBullet

extends RigidBody2D



func _ready():
	if $DamageDealerComponent:
		$DamageDealerComponent.final_pierce_reached.connect(queue_free)


func _on_body_entered(body) -> void:
	queue_free()
