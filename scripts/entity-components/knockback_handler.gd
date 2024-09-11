class_name KnockbackHandler

extends Node2D

var _physics_body: PhysicsBody2D

## 0-1 less knockback, 1+ more knockback
@export var knockback_resistance := 1.0

func _ready():
	_physics_body = get_parent().get_parent() if get_parent().get_parent() is PhysicsBody2D else null


func apply_knockback(knockback_velocity: Vector2):
	if _physics_body is RigidBody2D:
		_physics_body.apply_impulse(knockback_velocity * knockback_resistance)
	elif _physics_body is CharacterBody2D:
		_physics_body.velocity = Vector2(_physics_body.velocity.x + (knockback_velocity.x * knockback_resistance), _physics_body.velocity.y + (knockback_velocity.y * knockback_resistance))
