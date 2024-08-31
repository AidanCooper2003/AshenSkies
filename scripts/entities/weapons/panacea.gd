class_name Panacea

extends Weapon

@onready var _projectile_shooter := $ProjectileShooter
@export var heal_amount: int
@export var heal_chance: float

var health_component : HealthComponent

func _ready():
	super()
	health_component = get_character_node("HealthComponent")


func fire_primary(weapon_angle) -> bool:
	if _can_fire:
		if _get_can_heal():
			if randf() <= heal_chance:
					health_change_triggered.emit(heal_amount)
		else:
			condition_handler.add_condition("healthy", 0.4)
		_projectile_shooter.fire_bullet(weapon_angle)
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
