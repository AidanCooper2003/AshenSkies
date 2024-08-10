class_name BuffPotion

extends Weapon

@export var _condition_name: String
@export var _condition_length: float

var condition_handler: ConditionHandler


func _ready() -> void:
	super()
	condition_handler = get_character_node("ConditionHandler")


func fire_primary(weapon_angle) -> bool:
	if _can_fire && not condition_handler.has_condition(_condition_name):
		condition_handler.add_condition(_condition_name, _condition_length)
		durability -= 1;
		_can_fire = false
		_fire_delay_timer.start()
	if durability <= 0:
		weapon_broke.emit()
	return true
