class_name ResourceBreakable

extends Node2D

var resource: String

@export var _forced_resource: String
@export var _resource_count: int

func _ready():
	resource = _forced_resource
	if resource == "":
		resource = LevelManager.choose_random_resource()


func _on_damage_taken(damage_amount):
	EventBus.resource_added.emit(resource, _resource_count)
	queue_free()
