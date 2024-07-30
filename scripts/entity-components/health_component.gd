class_name HealthComponent

extends Node2D

signal health_changed(new_health: int, trigger_on_damage: bool)

@export var _max_health : int
@export var _simple_health : bool

var _current_health : int

func _ready() -> void:
	_current_health = _max_health
	health_changed.emit(_current_health, false)


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
