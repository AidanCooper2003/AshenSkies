class_name WeaponManager

extends Node2D

@export var _default_weapon: PackedScene

var weapon_angle
var instantiated_weapon : Weapon
var aim_position: Vector2

var _current_weapon_scene : PackedScene
var _weapon_holder: Node2D
var _aim_angle: Vector2

func _ready() -> void:
	if _default_weapon != null:
		_current_weapon_scene = _default_weapon
	_weapon_holder = get_child(0)
	draw_weapon()
	_aim_angle = Vector2.ZERO


func _physics_process(delta) -> void:
	aim()


func draw_weapon() -> void:
	if has_weapon():
		instantiated_weapon.queue_free()
	if _current_weapon_scene != null:
		instantiated_weapon = _current_weapon_scene.instantiate()
		_weapon_holder.add_child(instantiated_weapon)


func switch_weapon(newWeapon) -> void:
	_current_weapon_scene = newWeapon
	draw_weapon()


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
		var weapon_angle = (aim_position - global_position).normalized().angle()
		if weapon_angle >= PI/2 or weapon_angle <= -PI/2:
			instantiated_weapon.set_sprite_right()
		else:
			instantiated_weapon.set_sprite_left()
		_weapon_holder.global_position = global_position
		_weapon_holder.global_rotation = weapon_angle
		_aim_angle = (aim_position - _weapon_holder.global_position).normalized()
		
func has_weapon():
	return instantiated_weapon != null


##Returns 0 if no weapon is instantiated
func get_durability_percentage() -> float:
	if has_weapon():
		var durability_percentage := (
				float(instantiated_weapon.durability) / 
				float(instantiated_weapon.max_durability)) * 100
		return durability_percentage
	return 0.0
