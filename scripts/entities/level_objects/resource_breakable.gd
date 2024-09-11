class_name ResourceBreakable

extends Node2D

var resource: String

@export var _forced_resource: String
@export var _resource_count: int

var _resource_already_provided := false

func _ready():
	resource = _forced_resource
	if resource != "" && $ResourceIcon != null:
		$ResourceIcon.texture = load("res://sprites/resource_icons/" + resource + ".png")
	if resource == "":
		$ResourceIcon.texture = load("res://sprites/resource_icons/unknown_resource.png")
		resource = LevelManager.choose_random_resource()


func _on_damage_taken(damage_amount, _resistance_override):
	if not _resource_already_provided:
		_resource_already_provided = true
		EventBus.resource_added.emit(resource, _resource_count)
	queue_free()
