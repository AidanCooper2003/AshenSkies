extends Node2D

class_name AshPriest

@onready var _weapon_manager:= $WeaponManager

var target


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		target = body
		
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		target = null

		
func _physics_process(delta):
	if target != null:
		_weapon_manager.aimPosition = target.position
		_weapon_manager.fire_primary()


