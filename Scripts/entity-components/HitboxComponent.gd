extends Area2D

class_name HitboxComponent

signal damageTaken

func damage(damageAmount):
	print("damage taken")
	damageTaken.emit(damageAmount)
