class_name KillBound

extends Area2D



func _on_area_entered(area):
	if area is HitboxComponent:
		for i in range(100):
			area.force_damage(100)
