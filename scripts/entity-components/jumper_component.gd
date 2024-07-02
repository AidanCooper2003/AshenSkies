extends Node2D

class_name JumperComponent

@export var characterBody2D: CharacterBody2D

@export var jumpForce: float
@export var jumpDelay: float

@export var gravityComponent: GravityComponent


var currentJumps: int
@export var maxJumps: int

var wasOnFloor: bool
var isCoyoteState: bool
var isOnFloor: bool
var jumpQueued: bool
var canJump: bool = true

var coyoteTimer: Timer
var jumpCooldownTimer: Timer
var jumpQueueTimer: Timer



func _ready():
	jumpCooldownTimer = get_child(0)
	jumpCooldownTimer.wait_time = jumpDelay
	coyoteTimer = get_child(1)
	jumpQueueTimer = get_child(2)

func _physics_process(delta):
	if not isOnFloor and wasOnFloor:
		coyoteTimer.start()
		isCoyoteState = true
	wasOnFloor = isOnFloor
	if isOnFloor and currentJumps < maxJumps:
		currentJumps = maxJumps
	if jumpQueued:
		start_jump()

func jump():
	characterBody2D.velocity.y = -jumpForce
	gravityComponent.fastFallOverride = false
	if not isOnFloor and not isCoyoteState:
		currentJumps -= 1
	canJump = false
	jumpCooldownTimer.start()
	if jumpQueued:
		jumpQueued = false
	else:
		jumpQueueTimer.start()

func force_jump():
	characterBody2D.velocity.y = -jumpForce
	gravityComponent.fastFallOverride = false

func start_jump():
	if canJump and currentJumps >= 1:
		jump()

func release_jump():
	gravityComponent.fastFallOverride = true


func _on_character_change_on_floor_state(newFloorState):
	isOnFloor = newFloorState

func _on_jump_cooldown_timer_timeout():
	canJump = true

func _on_coyote_timer_timeout():
	isCoyoteState = false

func _on_jump_queue_timer_timeout():
	jumpQueued = false
