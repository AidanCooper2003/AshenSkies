extends Node2D

class_name WeaponInventoryManager


var weapons: Array = []

@export var weaponInventorySize: int

var currentWeapon: int = 0

func _ready():
	weapons.append(load("res://scenes/objects/weapons/test_gun.tscn"))
	weapons.append(load("res://scenes/objects/weapons/spikeball_launcher.tscn"))
	weapons.append(load("res://scenes/objects/weapons/dummy_gun.tscn"))

func has_weapons():
	return weapons.size() >= 1

func swap_weapon_left():
	if currentWeapon > 0:
		currentWeapon -= 1
	else:
		currentWeapon = min(weaponInventorySize, weapons.size() - 1)
	return weapons[currentWeapon]

func swap_weapon_right():
	if currentWeapon < weapons.size() - 1:
		currentWeapon += 1
	else:
		currentWeapon = 0
	return weapons[currentWeapon]

func swap_weapon(weaponIndex: int):
	currentWeapon = weaponIndex
	return weapons[currentWeapon]
