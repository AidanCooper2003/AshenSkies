class_name SingleProjectileShooter

extends ProjectileShooter


func fire_bullet(weapon_angle: Vector2):
	var damage_modifier = _get_damage_modification()
	var bullet_instance = _bullet.instantiate()
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.position = self.global_position
	bullet_instance.apply_impulse(weapon_angle * _bullet_velocity, Vector2.ZERO)
	bullet_instance.rotation = weapon_angle.angle()
	if bullet_instance.find_child("DamageDealerComponent"):
		bullet_instance.find_child("DamageDealerComponent").modify_damage(damage_modifier)
		print(damage_modifier)
		print(bullet_instance.find_child("DamageDealerComponent")._damage)
		
