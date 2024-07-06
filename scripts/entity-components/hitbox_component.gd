class_name HitboxComponent

extends Area2D

signal damage_taken(damage_amount: int)

func damage(damage_amount: int) -> void:
	damage_taken.emit(damage_amount)
