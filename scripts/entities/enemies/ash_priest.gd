class_name AshPriest

extends Node2D

var _target: Node2D

@onready var _weapon_manager := $WeaponManager

func _physics_process(delta) -> void:
	if _target != null:
		_weapon_manager.aim_position = _target.position
		_weapon_manager.fire_primary()


func _on_area_2d_body_entered(body) -> void:
	if body.name == "Player":
		_target = body


func _on_area_2d_body_exited(body) -> void:
	if body.name == "Player":
		_target = null
