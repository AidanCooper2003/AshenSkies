extends Node2D

class_name MeleeHandler

signal enable_damage
signal disable_damage

var isWeaponEnabled: bool

@export var swingTime: float

@export var swingTimer: Timer




func _ready():
	turn_off_weapon()
	swingTimer.wait_time = swingTime

func turn_on_weapon():
	isWeaponEnabled = true
	enable_damage.emit()


func turn_off_weapon():
	isWeaponEnabled = false
	disable_damage.emit()


func swing():
	turn_on_weapon()
	swingTimer.start()
