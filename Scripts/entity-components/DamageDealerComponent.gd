extends Area2D

class_name DamageDealerComponent

signal damage_dealt

@export var damage: float

func _on_area_entered(area):
	print("area entered")
	if area is HitboxComponent:
		area.damage(damage)
		damage_dealt.emit()
