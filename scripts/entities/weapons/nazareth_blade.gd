class_name NazarethBlade

extends Weapon

@export var _left_sprite: Texture2D
@export var _right_sprite: Texture2D

@onready var melee_handler:= $MeleeHandler

func fire_primary(_weapon_angle):
	if _can_fire:
		melee_handler.swing()
		durability -= 1
		_can_fire = false
		_fire_delay_timer.start()
	
	if durability <= 0:
		weapon_broke.emit()
	return true


func set_sprite_left():
	sprite.flip_v = false
	sprite.rotation = deg_to_rad(45)


func set_sprite_right():
	sprite.flip_v = true
	sprite.rotation = deg_to_rad(-45)
