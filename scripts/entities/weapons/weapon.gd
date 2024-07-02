extends Node2D

class_name Weapon

signal weapon_broke

@onready var fireDelayTimer:= $FireDelayTimer
@onready var sprite:= $Sprite2D

@export var fireDelay : float
@export var maxDurability : int

var durability

var canFire: bool

var isSpriteFlipped: bool



func _ready():
	durability = maxDurability
	fireDelayTimer.wait_time = fireDelay
	canFire = false
	fireDelayTimer.start()

func fire_primary(weaponAngle: Vector2):
	return false
	
func fire_secondary(weaponAngle: Vector2):
	return false

func fire_tertiary(weaponAngle: Vector2):
	return false

func set_sprite_right():
	scale = Vector2(1, -1)
	
func set_sprite_left():
	scale = Vector2(1, 1)

func _on_fire_delay_timer_timeout():
	canFire = true
