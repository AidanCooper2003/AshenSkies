extends CharacterBody2D

@onready var walkerComponent:= $WalkerComponent
@onready var jumperComponent:= $JumperComponent
@onready var objectDetector:= $ShapeCast2D
@onready var animationPlayer:= $AnimationPlayer

@export var relativeLeftBound: float
@export var relativeRightBound: float
@export var startingDirection: float = 1

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
		walkerComponent.walkDirection = currentWalkDirection
	elif position.x > actualRightBound:
		currentWalkDirection = -1
		walkerComponent.walkDirection = currentWalkDirection
	if objectDetector.is_colliding() && is_on_floor():
		jumperComponent.force_jump()
	move_and_slide()


func _on_health_component_health_changed(currentHealth):
	animationPlayer.play("hurt")
	if animationPlayer.is_playing():
		animationPlayer.stop()
		animationPlayer.play("hurt")
		animationPlayer.advance(0.1)
