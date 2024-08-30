extends Area2D

@export var _teleport_location : Vector2


func _on_body_entered(body):
	body.position = _teleport_location
