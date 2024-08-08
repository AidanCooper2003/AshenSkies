class_name Aura

extends Node2D

var connected_condition: String

func end_aura(condition):
	print(condition)
	if condition == connected_condition:
		queue_free()
