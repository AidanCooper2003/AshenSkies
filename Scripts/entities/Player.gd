extends CharacterBody2D

class_name Player


signal changeOnFloorState
signal healthChanged

@export var walkerComponent: WalkerComponent
@export var jumperComponent: JumperComponent
@export var weaponManager: WeaponManager
@export var animationPlayer: AnimationPlayer

@export var leftSprite: Texture
@export var rightSprite: Texture
@export var sprite2D: Sprite2D




var canJump := true
var wasOnFloor: bool


func _physics_process(_delta):
	handleWalk()
	handleJump()
	move_and_slide()
	handleWeaponFiring()

func handleWalk():
	if Input.is_action_pressed("Move Left") && !Input.is_action_pressed("Move Right"):
		sprite2D.texture = leftSprite
		walkerComponent.walkDirection = -1
	elif Input.is_action_pressed("Move Right") && !Input.is_action_pressed("Move Left"):
		sprite2D.texture = rightSprite
		walkerComponent.walkDirection = 1
	else:
		walkerComponent.walkDirection = 0

func handleJump():
	#wasOnFloor, coyoteTimer, isCoyoteState, isOnFloor (through signal), currentJumps, maxJumps, jumpQueued, canJump, jumpCooldownTimer
	if Input.is_action_just_pressed("Jump"):
		jumperComponent.start_jump()
	if Input.is_action_just_released("Jump"):
		jumperComponent.release_jump()
	if is_on_floor() != wasOnFloor:
		changeOnFloorState.emit(is_on_floor())
	wasOnFloor = is_on_floor()


func handleAim():
	weaponManager.aimPosition = get_global_mouse_position()

func handlePrimaryFire():
	if Input.is_action_pressed("Primary Fire"):
		weaponManager.fire_primary()
		
func handleSecondaryFire():
	if Input.is_action_pressed("Secondary Fire"):
		weaponManager.fire_secondary()

func handleTertiaryFire():
	if Input.is_action_pressed("Tertiary Fire"):
		weaponManager.fire_tertiary()
		
func handleWeaponFiring():
	handleAim()
	handlePrimaryFire()
	handleSecondaryFire()
	handleTertiaryFire()

func relayChangedHealth(newHealth: int):
	healthChanged.emit(newHealth)
	animationPlayer.play("iFrameFlashing")
