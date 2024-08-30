class_name HealthPotion

extends Weapon

@export var heal_amount: int

var health_component : HealthComponent

func _ready():
	super()
	health_component = get_character_node("HealthComponent")

func fire_primary(_weapon_angle):
	if _can_fire and _get_can_heal():
		health_change_triggered.emit(heal_amount)
		_decrement_durability()
		_can_fire = false
		_fire_delay_timer.start()
	if durability <= 0:
		weapon_broke.emit()
	return true

func _get_can_heal() -> bool:
	if health_component != null:
		return not health_component.get_at_max_health()
	return false

#Maybe add secondary here at some point to heal allies if those are added
