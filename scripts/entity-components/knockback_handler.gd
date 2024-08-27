class_name KnockbackHandler

extends Node2D

var _physics_body: PhysicsBody2D

func _ready():
	_physics_body = get_parent() if get_parent() is PhysicsBody2D else null


func apply_knockback(knockback_velocity: Vector2):
	if _physics_body is RigidBody2D:
		_physics_body.apply_impulse(knockback_velocity)
	elif _physics_body is CharacterBody2D:
		print(_physics_body.velocity)
		_physics_body.velocity = Vector2(_physics_body.velocity.x + knockback_velocity.x, _physics_body.velocity.y + knockback_velocity.y)
		print(_physics_body.velocity)
