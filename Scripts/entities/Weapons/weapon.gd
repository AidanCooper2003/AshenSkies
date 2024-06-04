extends Node2D

class_name Weapon

signal weapon_broke

@export var fireDelayTimer: Timer
@export var sprite: Sprite2D

@export var fireDelay : float
@export var durability : int


var canFire: bool = true

var isSpriteFlipped: bool



func _ready():
	fireDelayTimer.wait_time = fireDelay

func fire_primary(weaponAngle: float):
	return false
	
func fire_secondary(weaponAngle: float):
	return false

func fire_tertiary(weaponAngle: float):
	return false

func set_sprite_right():
	scale = Vector2(1, -1)
	
func set_sprite_left():
	scale = Vector2(1, 1)

func _on_fire_delay_timer_timeout():
	canFire = true
