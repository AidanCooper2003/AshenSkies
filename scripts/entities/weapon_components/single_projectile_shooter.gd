class_name SingleProjectileShooter

extends ProjectileShooter


func fire_bullet(weapon_angle: Vector2):
	var bullet_instance = _bullet.instantiate()
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.position = self.global_position
	bullet_instance.apply_impulse(weapon_angle * _bullet_velocity, Vector2.ZERO)
	bullet_instance.rotation = weapon_angle.angle()
