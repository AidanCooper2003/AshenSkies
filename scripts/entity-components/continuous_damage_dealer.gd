class_name ContinuousDamageDealer

extends Area2D

signal damage_dealt(damage: int)

@export var _damage: int
@export var _damage_delay: float
@export var _conditions: Dictionary
@export var _knockback: float

var _is_active: bool = true
var _damage_disabled: bool
var _targets: Dictionary = {}

func _physics_process(_delta) -> void:
	for area in _targets:
		if _targets.get(area) < Time.get_ticks_msec() - _damage_delay * 1000:
			_trigger_damage(area)

func _trigger_damage(area):
	if _damage > 0:
		area.damage(_damage)
		damage_dealt.emit()
	if not _conditions.is_empty():
		area.receive_conditions(_conditions)
	var knockback_handler = get_node(str(area.get_path()) + "/KnockbackHandler")
	if knockback_handler:
		knockback_handler.apply_knockback(global_position.direction_to(area.global_position) * _knockback)

func _on_area_entered(area) -> void:
	print("hello")
	if _is_active:
		if area is HitboxComponent:
			_targets[area] = Time.get_ticks_msec()
			_trigger_damage(area)

func _on_area_exited(area) -> void:
	if _is_active:
		if area is HitboxComponent:
			_targets.erase(area)
