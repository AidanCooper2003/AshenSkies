class_name DamageDealerComponent

extends Area2D

signal damage_dealt(damage: int)
signal final_pierce_reached()

@export var _damage: int
@export var _conditions: Dictionary
@export var _knockback: float
@export var _pierce: int

var _is_active: bool = true

func _on_area_entered(area) -> void:
	if !_is_active:
		return
	if not area is HitboxComponent:
		return
	_pierce -= 1
	if _damage > 0:
		area.damage(_damage)
		damage_dealt.emit()
	if not _conditions.is_empty():
		area.receive_conditions(_conditions)
	var knockback_handler = get_node_or_null(str(area.get_path()) + "/KnockbackHandler")
	if knockback_handler:
		knockback_handler.apply_knockback(global_position.direction_to(area.global_position) * _knockback)
	if _pierce <= 0:
		final_pierce_reached.emit()
		
func modify_damage(modifier: float):
	_damage *= modifier

