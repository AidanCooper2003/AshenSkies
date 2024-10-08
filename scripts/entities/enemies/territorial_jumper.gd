extends CharacterBody2D

@export var _relative_left_bound: float
@export var _relative_right_bound: float
@export var _starting_direction := 1

var _current_walk_direction: int
var _actual_left_bound: float
var _actual_right_bound: float

@onready var _walker_component:= $WalkerComponent
@onready var _jumper_component:= $JumperComponent
@onready var _enemy_detector:= $EnemyDetector
@onready var _animation_player:= $AnimationPlayer
@onready var _left_wall_detector:= $LeftWallDetector
@onready var _right_wall_detector:= $RightWallDetector

func _ready() -> void:
	_current_walk_direction = _starting_direction
	_actual_left_bound = position.x - _relative_left_bound
	_actual_right_bound = position.x + _relative_right_bound



func _physics_process(_delta) -> void:
	if position.x < _actual_left_bound:
		_current_walk_direction = 1
	elif position.x > _actual_right_bound:
		_current_walk_direction = -1
	elif _left_wall_detector.is_colliding():
		_current_walk_direction = 1
	elif _right_wall_detector.is_colliding():
		_current_walk_direction = -1
	if _enemy_detector.is_colliding() and is_on_floor():
		_jumper_component.force_jump()
	_walker_component.walk_direction = _current_walk_direction
	move_and_slide()


func _on_health_component_health_changed(_current_health: int, trigger_on_damage: bool) -> void:
	#Prevents a race condition with health's initial setting.
	if _animation_player == null:
		return
	if _animation_player.is_playing():
		_animation_player.stop()
		_animation_player.play("hurt")
		_animation_player.advance(0.03)
	_animation_player.play("hurt")

