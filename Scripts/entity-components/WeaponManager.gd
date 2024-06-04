extends Node2D

class_name WeaponManager

@export var currentWeapon : PackedScene
@export var weaponDistance: float


var instantiatedWeapon : Weapon
var weaponHolder: Node2D
var weaponAngle
var aimAngle
var leftWeaponRelativePosition: Vector2
var rightWeaponRelativePosition: Vector2

func _ready():
	weaponHolder = get_child(0)
	leftWeaponRelativePosition = get_child(1).position
	rightWeaponRelativePosition = get_child(2).position
	draw_weapon()

func _physics_process(delta):
	aim()

func draw_weapon():
	instantiatedWeapon = currentWeapon.instantiate()
	weaponHolder.add_child(instantiatedWeapon)
	print("Instantiated!")


# Print will show if the weapon has a fire mode with that button. In the future this will be replaced with a sound effect.
func fire_primary():
	if !instantiatedWeapon.fire_primary(aimAngle):
		print("no primary ability")

func fire_secondary():
	if !instantiatedWeapon.fire_secondary(aimAngle):
		print("no secondary ability")

func fire_tertiary():
	if !instantiatedWeapon.fire_tertiary(weaponAngle):
		print("no tertiary ability")

func aim():
	var weaponAngle = (get_global_mouse_position() - global_position).normalized().angle()
	if weaponAngle >= PI/2 || weaponAngle <= -PI/2:
		instantiatedWeapon.set_sprite_right()
		weaponHolder.global_position = global_position + leftWeaponRelativePosition
	else:
		instantiatedWeapon.set_sprite_left()
		weaponHolder.global_position = global_position + rightWeaponRelativePosition
	weaponHolder.global_rotation = weaponAngle
	aimAngle = (get_global_mouse_position() - weaponHolder.global_position).normalized()
