class_name Weapon

extends Node2D

signal weapon_broke

@export var _fire_delay: float
@export var maxDurability: int

var durability: int

var _can_fire: bool

@onready var _fire_delay_timer:= $FireDelayTimer
@onready var sprite:= $Sprite2D

func _ready():
	durability = maxDurability
	_fire_delay_timer.wait_time = _fire_delay
	_can_fire = false
	_fire_delay_timer.start()


func fire_primary(weapon_angle: Vector2):
	return false


func fire_secondary(weapon_angle: Vector2):
	return false


func fire_tertiary(weapon_angle: Vector2):
	return false


func set_sprite_right():
	scale = Vector2(1, -1)


func set_sprite_left():
	scale = Vector2(1, 1)


func _on_fire_delay_timer_timeout():
	_can_fire = true
