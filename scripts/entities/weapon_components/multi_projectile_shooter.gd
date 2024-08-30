class_name MultiProjectileShooter

extends ProjectileShooter

@export var bullet_count : int
@export var bullet_angle_variance : float
@export var bullet_velocity_variance : float
#Make sure to implement this in the future, if not random make it consistently spread
#If random keep same behavior as now
@export var is_bullet_variance_random : bool
@export var is_angle_variance_random : bool

func fire_bullet(weapon_angle: Vector2):
	var damage_modifier = _get_damage_modification()
	for i in range(bullet_count):
		var bullet_instance = _bullet.instantiate()
		var bullet_velocity_offset = randf_range(1 - bullet_velocity_variance, 1 + bullet_velocity_variance) 
		var bullet_angle_offset = randf_range(-bullet_angle_variance, bullet_angle_variance)
		var new_angle = Vector2.from_angle(weapon_angle.angle() + bullet_angle_offset)
		get_tree().current_scene.add_child(bullet_instance)
		bullet_instance.position = self.global_position
		bullet_instance.apply_impulse(new_angle * _bullet_velocity * bullet_velocity_offset, Vector2.ZERO)
		bullet_instance.rotation = new_angle.angle()
		if bullet_instance.find_child("DamageDealerComponent"):
			bullet_instance.find_child("DamageDealerComponent").modify_damage(damage_modifier)
			print(bullet_instance.find_child("DamageDealerComponent")._damage)
