##Used for guns that shoot projectiles with a straight directory.
##Place this at the end of the weapon where the bullet should spawn from.
class_name ProjectileShooter

extends Node2D

@export var _bullet : PackedScene
@export var _bullet_velocity : float

func fire_bullet(weapon_angle: Vector2) -> void:
	var bullet_instance = _bullet.instantiate()
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.position = self.global_position
	bullet_instance.apply_impulse(weapon_angle * _bullet_velocity, Vector2.ZERO)
	bullet_instance.rotation = weapon_angle.angle()
