extends Node2D

class_name GravityComponent

var defaultGravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var characterBody2D : CharacterBody2D

@export var gravityCoefficient : float = 1

var gravity

func _ready():
	gravity = defaultGravity * gravityCoefficient

func _physics_process(delta):
	if not characterBody2D.is_on_floor():
		characterBody2D.velocity.y += gravity * delta
