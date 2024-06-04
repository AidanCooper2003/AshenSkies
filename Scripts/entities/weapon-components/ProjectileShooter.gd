extends Node2D

class_name ProjectileShooter
# used for guns that shoot projectiles with a straight directory.
# place this at the end of the weapon where the bullet should spawn from.

@export var bullet : PackedScene

@export var bulletVelocity : float

func fire_bullet(weaponAngle: Vector2):
	var bulletInstance = bullet.instantiate()
	get_tree().get_root().add_child(bulletInstance)
	bulletInstance.position = self.global_position
	bulletInstance.apply_impulse(weaponAngle * bulletVelocity, Vector2.ZERO)
	bulletInstance.rotation = weaponAngle.angle()
