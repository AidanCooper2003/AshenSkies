class_name HealthComponent

extends Node2D

signal health_changed(new_health: int, trigger_on_damage: bool)

@export var _max_health : int
@export var _simple_health : bool

var _current_health : int
var _condition_handler: ConditionHandler
var _time_since_tick_damage: float

func _ready() -> void:
	_current_health = _max_health
	health_changed.emit(_current_health, false)
	await owner.ready
	_condition_handler = owner.get_node("ConditionHandler")


func _physics_process(delta):
	if (
			_condition_handler != null
			and _condition_handler.get_modification("damage_over_time") > 0 
		):
		_time_since_tick_damage += delta
		if _time_since_tick_damage > 0.1 && not _simple_health:
			take_damage(_condition_handler.get_modification("damage_over_time"))
		elif _simple_health:
			pass
	

func take_damage(damage : int) -> void:
	if not _simple_health:
		_current_health = clampi(_current_health - damage, 0, _max_health)
	else:
		_current_health -= 1
	health_changed.emit(_current_health, true)
	if _current_health <= 0:
		die()


func change_health(health : int) -> void:
	_current_health = clampi(_current_health + health, 0, _max_health)
	health_changed.emit(_current_health, false)

func die() -> void:
	get_parent().queue_free()


func get_at_max_health() -> bool:
	return _max_health == _current_health


func _on_hitbox_component_damage_taken(damageAmount) -> void:
	take_damage(damageAmount)
