##Used for guns that shoot projectiles with a straight directory.
##Place this at the end of the weapon where the bullet should spawn from.
class_name ProjectileShooter

extends Node2D

@export var _bullet : PackedScene
@export var _bullet_velocity : float

func fire_bullet(weapon_angle: Vector2) -> void:
	pass
