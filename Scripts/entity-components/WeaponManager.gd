extends Node2D

class_name WeaponManager

@export var currentWeapon : PackedScene
@export var weaponDistance: float


var instantiatedWeapon
var weaponHolder: Node2D
var weaponAngle

func _ready():
	weaponHolder = get_child(0)
	draw_weapon()

func _physics_process(delta):
	aim()

func draw_weapon():
	instantiatedWeapon = currentWeapon.instantiate()
	weaponHolder.add_child(instantiatedWeapon)
	print("Instantiated!")

func fire_primary():
	instantiatedWeapon.primary_fire(weaponAngle) 
	

func fire_secondary():
	print("Firing Weapon with Secondary Functionality!")

func fire_tertiary():
	print("Firing Weapon with Tertiary Functionality!")

func aim():
	var global_direction := ((get_global_mouse_position() - global_position).normalized()) * weaponDistance
	weaponHolder.global_position = global_position + global_direction
	weaponAngle = global_direction.angle()
	if weaponAngle >= PI/2 || weaponAngle <= -PI/2:
		instantiatedWeapon.set_sprite_right()
	else:
			instantiatedWeapon.set_sprite_left()
	weaponHolder.global_rotation = weaponAngle
