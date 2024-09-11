class_name HitboxComponent

extends Area2D

signal damage_taken(damage_amount: int, force: bool)
signal condition_added(condition: String, time: float)

func damage(damage_amount: int) -> void:
	damage_taken.emit(damage_amount, false)
	
func force_damage(damage_amount: int) -> void:
	damage_taken.emit(damage_amount, true)

#conditions should have key as condition name, value as time
func receive_conditions(conditions: Dictionary) -> void:
	for condition in conditions:
		condition_added.emit(condition, conditions[condition])
