extends Weapon

class_name BasicGun

@onready var projectileShooter:= $ProjectileShooter



func fire_primary(weaponAngle):
	if canFire:
		projectileShooter.fire_bullet(weaponAngle)
		durability -= 1;
		canFire = false
		fireDelayTimer.start()
	
	if durability <= 0:
		weapon_broke.emit()
	return true
