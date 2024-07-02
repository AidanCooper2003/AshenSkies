extends Area2D

class_name HitboxComponent

signal damageTaken

func damage(damageAmount: int):
	damageTaken.emit(damageAmount)
