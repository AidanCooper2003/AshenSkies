extends Node2D

class_name MeleeHandler

signal damage_enabled
signal damage_disabled

var _is_weapon_enabled: bool

@export var _swing_time: float
@export var _swing_timer: Timer

func _ready():
	_turn_off_weapon()
	_swing_timer.wait_time = _swing_time


func swing():
	_turn_on_weapon()
	_swing_timer.start()


func _turn_on_weapon():
	_is_weapon_enabled = true
	damage_enabled.emit()


func _turn_off_weapon():
	_is_weapon_enabled = false
	damage_disabled.emit()
