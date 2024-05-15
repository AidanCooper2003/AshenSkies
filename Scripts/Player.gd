extends CharacterBody2D

class_name Player
@export var walkerComponent: WalkerComponent
@export var jumperComponent: JumperComponent

@export var leftSprite: Texture
@export var rightSprite: Texture
@export var sprite2D: Sprite2D


func _physics_process(delta):
	if Input.is_action_pressed("Move Left") && !Input.is_action_pressed("Move Right"):
		sprite2D.texture = leftSprite
		walkerComponent.walkDirection = -1
	elif Input.is_action_pressed("Move Right") && !Input.is_action_pressed("Move Left"):
		sprite2D.texture = rightSprite
		walkerComponent.walkDirection = 1
	else:
		walkerComponent.walkDirection = 0
	if Input.is_action_pressed("Jump") && is_on_floor():
		jumperComponent.jump()
	print(velocity)
	move_and_slide()

