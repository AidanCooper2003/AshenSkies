extends CharacterBody2D

@export var walkerComponent: WalkerComponent
@export var jumperComponent: JumperComponent
@export var objectDetector: ShapeCast2D
@export var timer: Timer

@export var directionSwitchTime: float = 1
@export var startingDirection: float = 1

var currentWalkDirection

func _ready():
	currentWalkDirection = startingDirection
	timer.wait_time = directionSwitchTime



func _physics_process(delta):
	walkerComponent.walkDirection = currentWalkDirection
	if objectDetector.is_colliding() && is_on_floor():
		jumperComponent.jump()
	move_and_slide()


func _on_timer_timeout():
	currentWalkDirection = currentWalkDirection * -1
