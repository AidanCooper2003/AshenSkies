class_name ResourceBreakable

extends Node2D

var resource: String

func _ready():
	if resource == "":
		resource = LevelManager.choose_random_resource()


func _on_damage_taken(damage_amount):
	EventBus.resource_added.emit(resource, 3)
	queue_free()
