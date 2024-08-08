class_name DamageDealerComponent

extends Area2D

signal damage_dealt(damage: int)

@export var _damage: int
@export var _conditions: Dictionary

var _is_active: bool = true

func _on_area_entered(area) -> void:
	if _is_active:
		if area is HitboxComponent:
			area.damage(_damage)
			if not _conditions.is_empty():
				area.receive_conditions(_conditions)
			damage_dealt.emit()
