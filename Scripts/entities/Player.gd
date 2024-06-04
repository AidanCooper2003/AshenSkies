extends CharacterBody2D

class_name Player
@export var walkerComponent: WalkerComponent
@export var jumperComponent: JumperComponent
@export var jumpCooldownTimer: Timer
@export var weaponManager: WeaponManager

@export var leftSprite: Texture
@export var rightSprite: Texture
@export var sprite2D: Sprite2D

@export var maxJumps: int
@export var jumpDelay: float


var currentJumps
var canJump := true

func _ready():
	currentJumps = maxJumps
	jumpCooldownTimer.wait_time = jumpDelay


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
	if is_on_floor() && currentJumps < maxJumps:
		currentJumps = maxJumps
	
	if Input.is_action_just_pressed("Jump") && canJump && currentJumps >= 1:
		jumperComponent.jump()
		currentJumps -= 1
		canJump = false
		jumpCooldownTimer.start()
		
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
	handlePrimaryFire()
	handleSecondaryFire()
	handleTertiaryFire()


func _on_jump_cooldown_timer_timeout():
	canJump = true
