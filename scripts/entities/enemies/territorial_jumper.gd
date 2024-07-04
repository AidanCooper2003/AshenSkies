extends CharacterBody2D

@export var _relative_left_bound: float
@export var _relative_right_bound: float
@export var _starting_direction := 1

var _current_walk_direction: int
var _actual_left_bound: float
var _actual_right_bound: float

@onready var _walker_component:= $WalkerComponent
@onready var _jumper_component:= $JumperComponent
@onready var _object_detector:= $ShapeCast2D
@onready var _animation_player:= $AnimationPlayer

func _ready():
	_current_walk_direction = _starting_direction
	_actual_left_bound = position.x - _relative_left_bound
	_actual_right_bound = position.x + _relative_right_bound


func _physics_process(_delta):
	if position.x < _actual_left_bound:
		_current_walk_direction = 1
		_walker_component.walkDirection = _current_walk_direction
	elif position.x > _actual_right_bound:
		_current_walk_direction = -1
		_walker_component.walkDirection = _current_walk_direction
	if _object_detector.is_colliding() and is_on_floor():
		_jumper_component.force_jump()
	move_and_slide()


func _on_health_component_health_changed(currentHealth):
	_animation_player.play("hurt")
	if _animation_player.is_playing():
		_animation_player.stop()
		_animation_player.play("hurt")
		_animation_player.advance(0.1)
