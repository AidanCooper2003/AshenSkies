extends Area2D

class_name HitboxComponent

signal damageTaken

func damage(damageAmount):
	damageTaken.emit(damageAmount)
