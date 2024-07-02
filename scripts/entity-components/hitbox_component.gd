extends Area2D

class_name HitboxComponent

signal damage_taken

func damage(damageAmount: int):
	damage_taken.emit(damageAmount)
