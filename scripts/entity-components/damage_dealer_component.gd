extends Area2D

class_name DamageDealerComponent

signal damage_dealt

@export var damage: float

var isActive: bool = true


func _on_area_entered(area):
	if isActive:
		if area is HitboxComponent:
			area.damage(damage) 
			damage_dealt.emit()

func disable():
	isActive = false

func enable():
	isActive = true
