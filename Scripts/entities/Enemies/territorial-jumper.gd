extends CharacterBody2D

@export var walkerComponent: WalkerComponent
@export var jumperComponent: JumperComponent
@export var objectDetector: ShapeCast2D

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
		jumperComponent.jump()
	move_and_slide()


