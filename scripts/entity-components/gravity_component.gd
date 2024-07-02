extends Node2D

class_name GravityComponent

var defaultGravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var characterBody2D : CharacterBody2D

@export var gravityCoefficient : float = 1.0

var gravity

var fastFallOverride: bool

@export var downwardsGravityCoefficient: float

func _ready():
	gravity = defaultGravity * gravityCoefficient

func _physics_process(delta):
	if characterBody2D.velocity.y >= 0 or fastFallOverride:
		characterBody2D.velocity.y += gravity * downwardsGravityCoefficient * delta
	else:
		characterBody2D.velocity.y += gravity * delta
	if characterBody2D.is_on_floor():
		fastFallOverride = false
