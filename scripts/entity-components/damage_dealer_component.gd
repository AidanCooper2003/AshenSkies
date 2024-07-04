class_name DamageDealerComponent

extends Area2D

signal damage_dealt

@export var damage: float

var _is_active: bool = true

func _on_area_entered(area):
	if _is_active:
		if area is HitboxComponent:
			area.damage(damage) 
			damage_dealt.emit()
