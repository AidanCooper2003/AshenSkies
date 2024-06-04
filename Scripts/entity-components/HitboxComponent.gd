extends Area2D

class_name HitboxComponent

signal damageTaken

func damage(damageAmount: int):
	print("damage taken")
	damageTaken.emit(damageAmount)
