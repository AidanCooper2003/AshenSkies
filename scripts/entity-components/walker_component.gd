class_name WalkerComponent

extends Node2D

@export var _character_body_2d: CharacterBody2D
## How fast the entity should gain speed in its walk direction.
@export var _acceleration: float
## How much faster an entity should deccelerate than accelerate.
@export var _decceleration_coefficient: float
## How much slower an entity should deccelerate in the air compared to deccelerate on the ground.
@export var _air_decceleration_coefficient: float
## Maximum speed of entity.
@export var _max_velocity: float

## Which direction the entity is intended to move in. Should be -1, 0, or 1.
var walk_direction := 0

var _stopping_threshold := 1.0
var _condition_handler: ConditionHandler
var _acceleration_speed_modifier := 0.5
var _max_velocity_speed_modifier := 1.0

func _ready():
	await owner.ready
	_condition_handler = owner.get_node("ConditionHandler")

##If an entities velocity + acceleration is within the x velocity bounds, the entity may increase its speed.
##If an entities velocity is outside the bounds, do not set it lower in case the entity was launched.
##If an entities velocity is outside the bounds, moving in the opposite direction should slow it down.
func _physics_process(delta) -> void:
	if _character_body_2d == null:
		return
	var speed_modification := 1.0
	if _condition_handler != null:
		speed_modification = 1 + _condition_handler.get_modification("speed")
	var current_decceleration_rate = _decceleration_coefficient
	if not _character_body_2d.is_on_floor():
		current_decceleration_rate *= _air_decceleration_coefficient
	var velocity = _character_body_2d.velocity
	var intended_x_velocity
	var modified_acceleration = _acceleration * (1 + ((speed_modification - 1) * _acceleration_speed_modifier))
	var modified_max_velocity = _max_velocity * (1 + ((speed_modification - 1) * _max_velocity_speed_modifier))
	
	#If moving in the opposite direction than currently moving, use decceleration rate. Otherwise, accelerate normally.
	if sign(walk_direction) == sign(velocity.x):
		intended_x_velocity = velocity.x + (delta * walk_direction * modified_acceleration * (speed_modification + 1))
	else:
		intended_x_velocity = (
				velocity.x + (delta * walk_direction * current_decceleration_rate * modified_acceleration * (speed_modification + 1))
		)
	
	#If walk_direction is 0 or current velocity is outside of bounds, deccelerate
	if walk_direction == 0 || _character_body_2d.velocity.x >= modified_max_velocity || _character_body_2d.velocity.x <= -modified_max_velocity:
		var deccelerated_x_velocity = (
				velocity.x + (delta * modified_acceleration * current_decceleration_rate * -sign(velocity.x) * (speed_modification + 1))
		)
		# If decceleration would cause velocity to overshoot 0, set to 0.
		if abs(deccelerated_x_velocity) > abs(velocity.x) - _stopping_threshold:
			deccelerated_x_velocity = 0
		_character_body_2d.velocity = Vector2(deccelerated_x_velocity, velocity.y)
	
	#If movement is within bounds, or outside of bounds but getting closer to bounds.
	elif ( 
			((-modified_max_velocity <= intended_x_velocity) and (intended_x_velocity <= modified_max_velocity))
			or ((intended_x_velocity < -modified_max_velocity) and (intended_x_velocity > velocity.x))
			or ((intended_x_velocity > modified_max_velocity) and (intended_x_velocity < velocity.x))
	):
		_character_body_2d.velocity = Vector2(intended_x_velocity, velocity.y)
