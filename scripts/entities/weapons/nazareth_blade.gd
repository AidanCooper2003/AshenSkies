extends Weapon

class_name NazarethBlade


@export var leftSprite : Texture2D
@export var rightSprite : Texture2D

@onready var meleeHandler:= $MeleeHandler


func fire_primary(_weaponAngle):
	if canFire:
		meleeHandler.swing()
		durability -= 1;
		canFire = false
		fireDelayTimer.start()
	
	if durability <= 0:
		weapon_broke.emit()
	return true

func set_sprite_left():
	sprite.flip_v = false
	sprite.rotation = deg_to_rad(45)

func set_sprite_right():
	sprite.flip_v = true
	sprite.rotation = deg_to_rad(-45)
