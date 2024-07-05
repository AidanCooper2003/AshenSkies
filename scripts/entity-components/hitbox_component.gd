class_name HitboxComponent

extends Area2D

signal damage_taken

func damage(damage_amount: int) -> void:
	damage_taken.emit(damage_amount)
