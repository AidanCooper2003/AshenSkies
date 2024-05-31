extends Node2D

class_name HealthComponent

@export var maxHealth : int
@export var simpleHealth : bool

var currentHealth : int


func _ready():
	maxHealth = currentHealth

func takeDamage(damage : int):
	if !simpleHealth:
		currentHealth -= damage
	else:
		currentHealth -= 1


func _on_hitbox_component_damage_taken(damageAmount):
	takeDamage(damageAmount)
	print("Damage Taken!")
