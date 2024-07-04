extends Node2D


class_name WalkerComponent

@export var _character_body_2d: CharacterBody2D

## Which direction the entity is intended to move in. Should be -1, 0, or 1.
@export var walkDirection: int = 0

## How fast the entity should gain speed in its walk direction.
@export var acceleration: float

## How much faster an entity should deccelerate than accelerate.
@export var deccelerationCoefficient: float

## How much slower an entity should deccelerate in the air compared to deccelerate on the ground.
@export var airDeccelerationCoefficient: float

## Maximum speed of entity.
@export var maxVelocity: float

var stoppingThreshold: float = 1.0




##If an entities velocity + acceleration is within the x velocity bounds, the entity may increase its speed.
##If an entities velocity is outside the bounds, do not set it lower in case the entity was launched.
##If an entities velocity is outside the bounds, moving in the opposite direction should slow it down.

func _physics_process(delta):
	var currentDeccelerationRate = deccelerationCoefficient
	if not _character_body_2d.is_on_floor():
		currentDeccelerationRate *= airDeccelerationCoefficient
	var velocity = _character_body_2d.velocity
	var intendedXVelocity
	
	# If moving in the opposite direction than currently moving, use decceleration rate. Otherwise, accelerate normally.
	if sign(walkDirection) == sign(velocity.x):
		intendedXVelocity = velocity.x + (delta * walkDirection * acceleration)
	else:
		intendedXVelocity = (
				velocity.x + (delta * walkDirection * currentDeccelerationRate * acceleration)
		)
	
	# If walkDirection is 0, deccelerate
	if walkDirection == 0:
		var decceleratedXVelocity = (
				velocity.x + (delta * acceleration * currentDeccelerationRate * -sign(velocity.x))
		)
		# If decceleration would cause velocity to overshoot 0, set to 0.
		if abs(decceleratedXVelocity) > abs(velocity.x) - stoppingThreshold:
			decceleratedXVelocity = 0
		_character_body_2d.velocity = Vector2(decceleratedXVelocity, velocity.y)
	
	# If movement is within bounds, or outside of bounds but getting closer to bounds.
	elif ( 
			((-maxVelocity <= intendedXVelocity) and (intendedXVelocity <= maxVelocity))
			or ((intendedXVelocity < -maxVelocity) and (intendedXVelocity > velocity.x))
			or ((intendedXVelocity > maxVelocity) and (intendedXVelocity < velocity.x))
	):
		_character_body_2d.velocity = Vector2(intendedXVelocity, velocity.y)
