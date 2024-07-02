extends CharacterBody2D

class_name Player


signal changeOnFloorState
signal healthChanged
signal selectedNewWeapon
signal durabilityChanged
signal changeCraftingMenuState
signal resourceCountChanged
signal ingredientsChanged
signal weaponSlotChanged

@onready var walkerComponent:= $WalkerComponent
@onready var jumperComponent:= $JumperComponent
@onready var weaponManager:= $WeaponManager
@onready var animationPlayer:= $AnimationPlayer
@onready var weaponInventoryManager:= $WeaponInventoryManager
@onready var resourceInventoryManager:= $ResourceInventoryManager
@onready var craftingManager:= $CraftingManager
@onready var sprite2D:= $Sprite2D

@export var leftSprite: Texture
@export var rightSprite: Texture





var canJump := true
var wasOnFloor: bool
var craftingOpen: bool = false


func _physics_process(_delta):
	handle_walk()
	handle_jump()
	handle_weapon_firing()
	move_and_slide()
	handle_crafting_toggle()

func handle_walk():
	if Input.is_action_pressed("Move Left") && !Input.is_action_pressed("Move Right"):
		sprite2D.texture = leftSprite
		walkerComponent.walkDirection = -1
	elif Input.is_action_pressed("Move Right") && !Input.is_action_pressed("Move Left"):
		sprite2D.texture = rightSprite
		walkerComponent.walkDirection = 1
	else:
		walkerComponent.walkDirection = 0

func handle_jump():
	#wasOnFloor, coyoteTimer, isCoyoteState, isOnFloor (through signal), currentJumps, maxJumps, jumpQueued, canJump, jumpCooldownTimer
	if Input.is_action_just_pressed("Jump"):
		jumperComponent.start_jump()
	if Input.is_action_just_released("Jump"):
		jumperComponent.release_jump()
	if is_on_floor() != wasOnFloor:
		changeOnFloorState.emit(is_on_floor())
	wasOnFloor = is_on_floor()


func handle_aim():
	weaponManager.aimPosition = get_global_mouse_position()

func handle_primary_fire():
	if Input.is_action_pressed("Primary Fire"):
		weaponManager.fire_primary()
		
func handle_secondary_fire():
	if Input.is_action_pressed("Secondary Fire"):
		weaponManager.fire_secondary()

func handle_tertiary_fire():
	if Input.is_action_pressed("Tertiary Fire"):
		weaponManager.fire_tertiary()

func handle_weapon_swap():
	if Input.is_action_just_pressed("SwapWeaponDown"):
		weaponManager.switch_weapon(weaponInventoryManager.swap_weapon_left())
	if Input.is_action_just_pressed("SwapWeaponUp"):
		weaponManager.switch_weapon(weaponInventoryManager.swap_weapon_right())
	selectedNewWeapon.emit(weaponInventoryManager.currentWeapon)
	
func handle_weapon_durability():
	if weaponManager.instantiatedWeapon != null:
		var durabilityPercentage = (float(weaponManager.instantiatedWeapon.durability) / float(weaponManager.instantiatedWeapon.maxDurability)) * 100
		durabilityChanged.emit(weaponInventoryManager.currentWeapon, durabilityPercentage)
	
func handle_crafting_toggle():
	if Input.is_action_just_pressed("ToggleCraftingMenu"):
		craftingOpen = !craftingOpen
		changeCraftingMenuState.emit(craftingOpen)



# Later you should still be able to fire, but only if its outside the bounds
# of the crafting menu
func handle_weapon_firing():
	handle_aim()
	if !craftingOpen:
		handle_primary_fire()
		handle_secondary_fire()
		handle_tertiary_fire()
	handle_weapon_swap()
	handle_weapon_durability()

func add_to_crafting(resourceName: String):
	resourceInventoryManager.add_resource_to_crafting(resourceName)
	ingredientsChanged.emit(resourceInventoryManager.resourcesInCrafting)
	
func remove_from_crafting(resourceName: String):
	resourceInventoryManager.subtract_resource_from_crafting(resourceName)
	ingredientsChanged.emit(resourceInventoryManager.resourcesInCrafting)
	
func reset_crafting():
	resourceInventoryManager.reset_crafting()
	ingredientsChanged.emit(resourceInventoryManager.resourcesInCrafting)

func start_crafting():
	print(resourceInventoryManager.resourcesInCrafting)
	print(resourceInventoryManager.get_crafting_count())
	if resourceInventoryManager.get_crafting_count() == 8:
		var item = craftingManager.craft(resourceInventoryManager.resourcesInCrafting)
		var itemScene = CSVManager.get_item_scene(item)
		if itemScene != null:
			weaponInventoryManager.add_weapon(itemScene)
		weaponSlotChanged.emit(weaponInventoryManager.weapons.size() - 1, item)


func relay_changed_health(newHealth: int):
	healthChanged.emit(newHealth)
	animationPlayer.play("iFrameFlashing")


func _on_resource_inventory_manager_resource_count_changed(resourceName: String, resourceCount: int):
	resourceCountChanged.emit(resourceName, resourceCount)
