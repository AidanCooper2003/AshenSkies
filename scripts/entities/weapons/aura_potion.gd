class_name AuraPotion

extends Weapon

@export var _aura: PackedScene
@export var _aura_duration: float

var condition_handler: ConditionHandler

func _ready():
	super()
	condition_handler = get_character_node("ConditionHandler")

func fire_primary(weapon_angle) -> bool:
	if _can_fire && not aura_present():
		instantiate_aura()
		durability -= 1;
		_can_fire = false
		_fire_delay_timer.start()
	if durability <= 0:
		weapon_broke.emit()
	return true

func instantiate_aura() -> void:
	if condition_handler == null:
		return
	condition_handler.add_condition(weapon_name, _aura_duration)
	var aura_instance: Aura
	aura_instance = _aura.instantiate()
	aura_instance.connected_condition = weapon_name
	character.add_child(aura_instance)
	condition_handler.condition_expired.connect(aura_instance.end_aura)

func aura_present() -> bool:
	if condition_handler == null:
		return false
	if condition_handler.has_condition(weapon_name):
		return true
	return false
