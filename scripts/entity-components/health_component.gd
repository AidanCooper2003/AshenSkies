class_name HealthComponent

extends Node2D

signal health_changed

@export var _max_health : int
@export var _simple_health : bool

var _current_health : int

func _ready() -> void:
	_current_health = _max_health


func take_damage(damage : int) -> void:
	if not _simple_health:
		_current_health -= damage
	else:
		_current_health -= 1
	health_changed.emit(_current_health)
	if _current_health <= 0:
		die()


func die() -> void:
	get_parent().queue_free()


func _on_hitbox_component_damage_taken(damageAmount) -> void:
	take_damage(damageAmount)
