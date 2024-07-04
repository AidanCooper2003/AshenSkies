class_name WeaponInventoryManager

extends Node2D

signal item_slot_changed

@export var _weapon_inventory_size: int

var weapons := []
var _current_weapon := 0

func has_weapons():
	return weapons.size() >= 1

func has_room():
	return weapons.size() < 4

func add_weapon(weapon: String):
	if has_room():
		weapons.append(load("res://scenes/objects/weapons/" + weapon))

func swap_weapon_left():
	if not has_weapons():
		return
	if _current_weapon > 0:
		_current_weapon -= 1
	else:
		_current_weapon = min(_weapon_inventory_size, weapons.size() - 1)
	return weapons[_current_weapon]

func swap_weapon_right():
	if not has_weapons():
		return
	if _current_weapon < weapons.size() - 1:
		_current_weapon += 1
	else:
		_current_weapon = 0
	return weapons[_current_weapon]

func swap_weapon(weapon_index: int):
	_current_weapon = weapon_index
	return weapons[_current_weapon]
