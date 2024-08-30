class_name BuffPotion

extends Weapon

@export var _condition_name: String
@export var _condition_length: float

func fire_primary(weapon_angle) -> bool:
	if _can_fire && not condition_handler.has_condition(_condition_name):
		_decrement_durability()
		condition_handler.add_condition(_condition_name, _condition_length)
		_can_fire = false
		_fire_delay_timer.start()
	if durability <= 0:
		weapon_broke.emit()
	return true
