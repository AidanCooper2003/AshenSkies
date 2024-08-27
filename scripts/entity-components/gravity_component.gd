class_name GravityComponent

extends Node2D

@export var _character_body_2d: CharacterBody2D
@export var _downwards_gravity_coefficient := 1.0
@export var _gravity_coefficient := 1.0

var _gravity: float
var fast_fall_override: bool

@onready var defaultGravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	_gravity = defaultGravity * _gravity_coefficient


func _physics_process(delta) -> void:
	if _character_body_2d.velocity.y >= 0 or fast_fall_override:
		_character_body_2d.velocity.y += _gravity * _downwards_gravity_coefficient * delta
	else:
		_character_body_2d.velocity.y += _gravity * delta
	if _character_body_2d.is_on_floor():
		fast_fall_override = false
