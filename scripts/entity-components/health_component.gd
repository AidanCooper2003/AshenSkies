extends Node2D

class_name HealthComponent

signal health_changed

@export var maxHealth : int
@export var simpleHealth : bool

var currentHealth : int


func _ready():
	currentHealth = maxHealth

func take_damage(damage : int):
	if not simpleHealth:
		currentHealth -= damage
	else:
		currentHealth -= 1
	health_changed.emit(currentHealth)
	if currentHealth <= 0:
		die()

func die():
	get_parent().queue_free()

func _on_hitbox_component_damage_taken(damageAmount):
	take_damage(damageAmount)

