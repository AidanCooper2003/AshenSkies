class_name WeaponInventoryManager

extends Node2D

@export var _weapon_inventory_size: int

var weapons := []

var current_weapon := 0

func has_weapons() -> bool:
	return weapons.size() >= 1

func has_room() -> bool:
	return weapons.size() < 4

func add_weapon(weapon: String) -> void:
	if has_room():
		weapons.append(load("res://scenes/objects/weapons/" + weapon))

func swap_weapon_left() -> Object:
	if not has_weapons():
		return null
	if current_weapon > 0:
		current_weapon -= 1
	else:
		current_weapon = min(_weapon_inventory_size, weapons.size() - 1)
	return weapons[current_weapon]

func swap_weapon_right() -> Object:
	if not has_weapons():
		return
	if current_weapon < weapons.size() - 1:
		current_weapon += 1
	else:
		current_weapon = 0
	return weapons[current_weapon]

func swap_weapon(weapon_index: int) -> Object:
	current_weapon = weapon_index
	return weapons[current_weapon]
