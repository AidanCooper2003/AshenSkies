class_name Weapon

extends Node2D

signal weapon_broke

@export var _fire_delay: float
@export var _max_durability: int

var _can_fire := false

@onready var _fire_delay_timer := $FireDelayTimer
@onready var sprite := $Sprite2D
@onready var durability := _max_durability

func _ready() -> void:
	_fire_delay_timer.wait_time = _fire_delay
	_fire_delay_timer.start()


func fire_primary(weapon_angle: Vector2) -> bool:
	return false


func fire_secondary(weapon_angle: Vector2) -> bool:
	return false


func fire_tertiary(weapon_angle: Vector2) -> bool:
	return false


func set_sprite_right() -> void:
	scale = Vector2(1, -1)


func set_sprite_left() -> void:
	scale = Vector2(1, 1)


func _on_fire_delay_timer_timeout() -> void:
	_can_fire = true
