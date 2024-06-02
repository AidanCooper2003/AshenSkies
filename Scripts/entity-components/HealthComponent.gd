extends Node2D

class_name HealthComponent

@export var maxHealth : int
@export var simpleHealth : bool

var currentHealth : int


func _ready():
	currentHealth = maxHealth

func takeDamage(damage : int):
	if !simpleHealth:
		currentHealth -= damage
	else:
		currentHealth -= 1
	if currentHealth <= 0:
		die()

func die():
	print("This has died!")
	get_parent().queue_free()

func _on_hitbox_component_damage_taken(damageAmount):
	takeDamage(damageAmount)
	print("Damage Taken!")
