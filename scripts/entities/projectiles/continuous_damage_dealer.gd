extends Area2D

class_name ContinuousDamageDealer

signal damage_dealt

@export var damage: float
@export var damageDelay: float


var isActive: bool = true
var damageDisabled: bool

var targets: Dictionary = {}



func _on_area_entered(area):
	if isActive:
		if area is HitboxComponent:
			targets[area] = Time.get_ticks_msec()
			area.damage(damage)

func _on_area_exited(area):
	if isActive:
		if area is HitboxComponent:
			targets.erase(area)

func _physics_process(delta):
	for area in targets:
		if targets.get(area) < Time.get_ticks_msec() - damageDelay * 1000:
			area.damage(damage)


func disable():
	isActive = false

func enable():
	isActive = true
