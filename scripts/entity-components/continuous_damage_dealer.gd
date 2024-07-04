extends Area2D

class_name ContinuousDamageDealer

signal damage_dealt

@export var damage: float
@export var damageDelay: float

var _is_active: bool = true
var _damage_disabled: bool
var _targets: Dictionary = {}

func _physics_process(_delta):
	for area in _targets:
		if _targets.get(area) < Time.get_ticks_msec() - damageDelay * 1000:
			area.damage(damage)


func _on_area_entered(area):
	if _is_active:
		if area is HitboxComponent:
			_targets[area] = Time.get_ticks_msec()
			area.damage(damage)


func _on_area_exited(area):
	if _is_active:
		if area is HitboxComponent:
			_targets.erase(area)
