extends Node2D

class_name BasicGun

signal weapon_broke

@export var fireDelayTimer: Timer
@export var sprite: Sprite2D
@export var firePoint: Node2D

# Make this an exported variable, also make more general class
@export var bullet: PackedScene

@export var fireDelay : float
@export var durability : int
@export var bulletVelocity : float


var canFire: bool = true

var isSpriteFlipped: bool



func _ready():
	fireDelayTimer.wait_time = fireDelay

func primary_fire(weaponAngle: float):
	if canFire:
		fire_bullet(weaponAngle)
		durability -= 1;
		canFire = false
		fireDelayTimer.start()
	
	if durability <= 0:
		weapon_broke.emit()

func fire_bullet(weaponAngle: float):
	var bulletInstance = bullet.instantiate()
	get_tree().get_root().add_child(bulletInstance)
	bulletInstance.position = firePoint.global_position
	bulletInstance.apply_impulse(Vector2(cos(weaponAngle), sin(weaponAngle)) * bulletVelocity, Vector2.ZERO)
	bulletInstance.rotation = weaponAngle
	
	
func set_sprite_right():
	isSpriteFlipped = true
	sprite.flip_v = isSpriteFlipped
	
func set_sprite_left():
	isSpriteFlipped = false
	sprite.flip_v = isSpriteFlipped


func _on_fire_delay_timer_timeout():
	canFire = true
