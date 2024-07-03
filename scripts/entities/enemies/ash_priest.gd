class_name AshPriest
extends Node2D

var _target

@onready var _weapon_manager:= $WeaponManager

func _physics_process(delta):
	if _target != null:
		_weapon_manager.aimPosition = _target.position
		_weapon_manager.fire_primary()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		_target = body


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		_target = null
