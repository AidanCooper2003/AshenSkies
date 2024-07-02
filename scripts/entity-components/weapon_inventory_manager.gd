extends Node2D

class_name WeaponInventoryManager

signal item_slot_changed
var weapons: Array = []

@export var weaponInventorySize: int

var currentWeapon: int = 0

func _ready():
	#weapons.append(load("res://scenes/objects/weapons/test_gun.tscn"))
	#weapons.append(load("res://scenes/objects/weapons/spikeball_launcher.tscn"))
	#weapons.append(load("res://scenes/objects/weapons/dummy_gun.tscn"))
	pass

func has_weapons():
	return weapons.size() >= 1

func has_room():
	return weapons.size() < 4

func add_weapon(weapon: String):
	print(weapons.size())
	if has_room():
		weapons.append(load("res://scenes/objects/weapons/" + weapon))

func swap_weapon_left():
	if !has_weapons():
		return
	if currentWeapon > 0:
		currentWeapon -= 1
	else:
		currentWeapon = min(weaponInventorySize, weapons.size() - 1)
	return weapons[currentWeapon]

func swap_weapon_right():
	if !has_weapons():
		return
	if currentWeapon < weapons.size() - 1:
		currentWeapon += 1
	else:
		currentWeapon = 0
	return weapons[currentWeapon]

func swap_weapon(weaponIndex: int):
	currentWeapon = weaponIndex
	return weapons[currentWeapon]
