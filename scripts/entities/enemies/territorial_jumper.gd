extends CharacterBody2D

@onready var _walker_component:= $_walker_component
@onready var _jumper_component:= $JumperComponent
@onready var objectDetector:= $ShapeCast2D
@onready var _animation_player:= $AnimationPlayer

@export var relativeLeftBound: float
@export var relativeRightBound: float
@export var startingDirection: float = 1.0

var currentWalkDirection
var actualLeftBound: float
var actualRightBound: float

func _ready():
	currentWalkDirection = startingDirection
	actualLeftBound = position.x - relativeLeftBound
	actualRightBound = position.x + relativeRightBound




func _physics_process(_delta):
	if position.x < actualLeftBound:
		currentWalkDirection = 1
		_walker_component.walkDirection = currentWalkDirection
	elif position.x > actualRightBound:
		currentWalkDirection = -1
		_walker_component.walkDirection = currentWalkDirection
	if objectDetector.is_colliding() and is_on_floor():
		_jumper_component.force_jump()
	move_and_slide()


func _on_health_component_health_changed(currentHealth):
	_animation_player.play("hurt")
	if _animation_player.is_playing():
		_animation_player.stop()
		_animation_player.play("hurt")
		_animation_player.advance(0.1)
