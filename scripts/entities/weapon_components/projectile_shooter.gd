##Used for guns that shoot projectiles with a straight directory.
##Place this at the end of the weapon where the bullet should spawn from.
class_name ProjectileShooter

extends Node2D

@export var _bullet : PackedScene
@export var _bullet_velocity : float

var parent_has_condition_handler := false

func _ready():
	await(owner.ready)
	var parent = get_parent()
	if parent is Weapon && parent.condition_handler != null:
		parent_has_condition_handler = true

func fire_bullet(weapon_angle: Vector2) -> void:
	pass


func _get_damage_modification() -> float:
	var damage_modifier := 1.0
	if parent_has_condition_handler:
		var condition_handler = get_parent().condition_handler
		print(condition_handler.conditions)
		if condition_handler.has_modification("damage_dealt"):
			damage_modifier += condition_handler.get_modification("damage_dealt")
	return damage_modifier
	
