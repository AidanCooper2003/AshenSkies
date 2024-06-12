extends Node2D

class_name WeaponManager

@export var currentWeapon : PackedScene
@export var weaponDistance: float


var instantiatedWeapon : Weapon
var weaponHolder: Node2D
var weaponAngle
var aimAngle

var aimPosition: Vector2

func _ready():
	weaponHolder = get_child(0)
	draw_weapon()
	aimAngle = Vector2.ZERO

func _physics_process(delta):
	aim()

func draw_weapon():
	instantiatedWeapon = currentWeapon.instantiate()
	weaponHolder.add_child(instantiatedWeapon)


# Print will show if the weapon has a fire mode with that button. In the future this will be replaced with a sound effect.
func fire_primary():
	if !instantiatedWeapon.fire_primary(aimAngle):
		print("no primary ability")

func fire_secondary():
	if !instantiatedWeapon.fire_secondary(aimAngle):
		print("no secondary ability")

func fire_tertiary():
	if !instantiatedWeapon.fire_tertiary(aimAngle):
		print("no tertiary ability")

func aim():
	var weaponAngle = (aimPosition - global_position).normalized().angle()
	if weaponAngle >= PI/2 || weaponAngle <= -PI/2:
		instantiatedWeapon.set_sprite_right()
	else:
		instantiatedWeapon.set_sprite_left()
	weaponHolder.global_position = global_position
	weaponHolder.global_rotation = weaponAngle
	aimAngle = (aimPosition - weaponHolder.global_position).normalized()
