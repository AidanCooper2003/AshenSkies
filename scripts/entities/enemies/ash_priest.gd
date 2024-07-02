extends Node2D

class_name AshPriest

@onready var weaponManager:= $WeaponManager

var target


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		target = body
		
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		target = null

		
func _physics_process(delta):
	if target != null:
		weaponManager.aimPosition = target.position
		weaponManager.fire_primary()


