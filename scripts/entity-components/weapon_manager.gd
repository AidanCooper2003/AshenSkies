class_name WeaponManager

extends Node2D

@export var _default_weapon: PackedScene

var weapon_angle
var instantiated_weapon : Weapon
var aim_position: Vector2

var _weapon_holder: Node2D
var _aim_angle: Vector2

func _ready() -> void:
	_weapon_holder = get_child(0)
	if _default_weapon != null:
		instantiated_weapon = _default_weapon.instantiate()
		_weapon_holder.add_child(instantiated_weapon)
	_aim_angle = Vector2.ZERO


func add_weapon(weapon_instance: Weapon):
	if instantiated_weapon == null:
		instantiated_weapon = weapon_instance
	_weapon_holder.add_child(weapon_instance)


func _physics_process(delta) -> void:
	aim()


#Print will show if the weapon has a fire mode with that button. In the future this will be replaced with a sound effect.
func fire_primary() -> void:
	if has_weapon() && not instantiated_weapon.fire_primary(_aim_angle):
			print("no primary ability")


func fire_secondary() -> void:
	if has_weapon() && not instantiated_weapon.fire_secondary(_aim_angle):
		print("no secondary ability")


func fire_tertiary() -> void:
	if has_weapon() && not instantiated_weapon.fire_tertiary(_aim_angle):
		print("no tertiary ability")


func aim() -> void:
	if has_weapon():
		weapon_angle = (aim_position - global_position).normalized().angle()
		if weapon_angle >= PI/2 or weapon_angle <= -PI/2:
			instantiated_weapon.set_sprite_right()
		else:
			instantiated_weapon.set_sprite_left()
		_weapon_holder.global_position = global_position
		_weapon_holder.global_rotation = weapon_angle
		_aim_angle = (aim_position - _weapon_holder.global_position).normalized()


func has_weapon():
	return instantiated_weapon != null
