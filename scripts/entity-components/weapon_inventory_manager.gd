class_name WeaponInventoryManager

extends Node2D

@export var weapon_inventory_size: int
@export var _weapon_manager: WeaponManager

var weapons := []
var current_weapon := 0

func has_weapons() -> bool:
	return weapons.size() >= 1


func has_multiple_weapons() -> bool:
	return weapons.size() >= 2


func has_room() -> bool:
	return weapons.size() < 4


func add_weapon(weapon: String) -> void:
	if has_room():
		var weapon_instance = load("res://scenes/objects/weapons/" + weapon).instantiate()
		_weapon_manager.add_weapon(weapon_instance)
		if !has_weapons():
			weapon_instance.enable()
		weapons.append(weapon_instance)



func swap_weapon_left() -> void:
	if has_multiple_weapons():
		weapons[current_weapon].disable()
		if current_weapon > 0:
			current_weapon -= 1
		else:
			current_weapon = min(weapon_inventory_size, weapons.size() - 1)
		_reset_weapon()


func swap_weapon_right() -> void:
	if has_multiple_weapons():
		weapons[current_weapon].disable()
		if current_weapon < weapons.size() - 1:
			current_weapon += 1
		else:
			current_weapon = 0
		_reset_weapon()


func swap_weapon(weapon_index: int) -> Object:
	current_weapon = weapon_index
	_reset_weapon()
	return weapons[current_weapon]


func remove_weapon(weapon_index: int) -> void:
	var removed_weapon = weapons[weapon_index]
	weapons.remove_at(weapon_index)
	if !has_weapons():
		_weapon_manager.instantiated_weapon = null
	elif current_weapon >= weapons.size():
		swap_weapon(current_weapon - 1)
	else:
		swap_weapon(current_weapon)
	removed_weapon.queue_free()
	
	
func remove_current_weapon() -> void:
	remove_weapon(current_weapon)
	

func get_weapon_name(weapon_index: int) -> String:
	if weapon_index <= weapons.size() - 1:
		return weapons[weapon_index].weapon_name
	return ""

func get_weapon_durability(weapon_index: int) -> int:
	if weapon_index <= weapons.size() - 1:
		return weapons[weapon_index].durability
	return 0.0

func _reset_weapon():
	if has_weapons:
		_weapon_manager.instantiated_weapon = weapons[current_weapon]
		weapons[current_weapon].enable()
	else:
		_weapon_manager.instantiated_weapon = null
