class_name BasicGun

extends Weapon

@onready var _projectile_shooter := $ProjectileShooter

func fire_primary(weapon_angle) -> bool:
	if _can_fire:
		_projectile_shooter.fire_bullet(weapon_angle)
		_decrement_durability()
		_can_fire = false
		_fire_delay_timer.start()
	if durability <= 0:
		weapon_broke.emit()
	return true
