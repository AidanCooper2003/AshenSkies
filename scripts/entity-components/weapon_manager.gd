extends Node2D

class_name WeaponManager

@export var weaponDistance: float
@export var defaultWeapon: PackedScene


var currentWeaponScene : PackedScene
var instantiatedWeapon : Weapon
var weaponHolder: Node2D
var weaponAngle
var aimAngle

var aimPosition: Vector2

func _ready():
	if defaultWeapon != null:
		currentWeaponScene = defaultWeapon
	weaponHolder = get_child(0)
	draw_weapon()
	aimAngle = Vector2.ZERO


func _physics_process(delta):
	aim()

func draw_weapon():
	if instantiatedWeapon != null:
		instantiatedWeapon.queue_free()
	if currentWeaponScene != null:
		instantiatedWeapon = currentWeaponScene.instantiate()
		weaponHolder.add_child(instantiatedWeapon)

func switch_weapon(newWeapon):
	currentWeaponScene = newWeapon
	draw_weapon()

#Print will show if the weapon has a fire mode with that button. In the future this will be replaced with a sound effect.
func fire_primary():
	if instantiatedWeapon != null:
		if not instantiatedWeapon.fire_primary(aimAngle):
			print("no primary ability")

func fire_secondary():
	if instantiatedWeapon != null:
		if not instantiatedWeapon.fire_secondary(aimAngle):
			print("no secondary ability")

func fire_tertiary():
	if instantiatedWeapon != null:
		if not instantiatedWeapon.fire_tertiary(aimAngle):
			print("no tertiary ability")

func aim():
	if instantiatedWeapon != null:
		var weaponAngle = (aimPosition - global_position).normalized().angle()
		if weaponAngle >= PI/2 or weaponAngle <= -PI/2:
			instantiatedWeapon.set_sprite_right()
		else:
			instantiatedWeapon.set_sprite_left()
		weaponHolder.global_position = global_position
		weaponHolder.global_rotation = weaponAngle
		aimAngle = (aimPosition - weaponHolder.global_position).normalized()
