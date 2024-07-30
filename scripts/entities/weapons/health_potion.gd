class_name HealthPotion

extends Weapon

@export var heal_amount: int

func fire_primary(_weapon_angle):
	if _can_fire:
		health_change_triggered.emit(heal_amount)
		durability -= 1;
		_can_fire = false
		_fire_delay_timer.start()
	if durability <= 0:
		weapon_broke.emit()
	return true

#Maybe add secondary here at some point to heal allies if those are added
