class_name DamageDealerComponent

extends Area2D

signal damage_dealt(damage: int)

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
	var knockback_handler = get_node(str(area.get_path()) + "/KnockbackHandler")
	if knockback_handler:
		print("Knocky Wocky!")
		knockback_handler.apply_knockback(global_position.direction_to(area.global_position) * _knockback)
	print(_pierce)
	if _pierce <= 0:
		get_parent().queue_free()

