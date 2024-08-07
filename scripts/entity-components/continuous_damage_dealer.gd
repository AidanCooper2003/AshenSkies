class_name ContinuousDamageDealer

extends Area2D

signal damage_dealt(damage: int)

@export var _damage: int
@export var _damage_delay: float

var _is_active: bool = true
var _damage_disabled: bool
var _targets: Dictionary = {}

func _physics_process(_delta) -> void:
	for area in _targets:
		if _targets.get(area) < Time.get_ticks_msec() - _damage_delay * 1000:
			area.damage(_damage)


func _on_area_entered(area) -> void:
	if _is_active:
		if area is HitboxComponent:
			_targets[area] = Time.get_ticks_msec()
			area.damage(_damage)


func _on_area_exited(area) -> void:
	if _is_active:
		if area is HitboxComponent:
			_targets.erase(area)
