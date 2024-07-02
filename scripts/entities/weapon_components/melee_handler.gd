extends Node2D

class_name MeleeHandler

signal enableDamage
signal disableDamage

var isWeaponEnabled: bool

@export var swingTime: float

@export var swingTimer: Timer



# Called when the node enters the scene tree for the first time.
func _ready():
	turnOffWeapon()
	swingTimer.wait_time = swingTime

func turnOnWeapon():
	isWeaponEnabled = true
	enableDamage.emit()
	print("weapon on")

func turnOffWeapon():
	isWeaponEnabled = false
	disableDamage.emit()
	print("weapon off")

func swing():
	turnOnWeapon()
	swingTimer.start()
