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

@export var walkerComponent: WalkerComponent
@export var jumperComponent: JumperComponent
@export var weaponManager: WeaponManager
@export var animationPlayer: AnimationPlayer
@export var weaponInventoryManager: WeaponInventoryManager
@export var resourceInventoryManager: ResourceInventoryManager
@export var craftingManager: CraftingManager

@export var leftSprite: Texture
@export var rightSprite: Texture
@export var sprite2D: Sprite2D




var canJump := true
var wasOnFloor: bool
var craftingOpen: bool = false


func _physics_process(_delta):
	handleWalk()
	handleJump()
	handleWeaponFiring()
	move_and_slide()
	handleCraftingToggle()

func handleWalk():
	if Input.is_action_pressed("Move Left") && !Input.is_action_pressed("Move Right"):
		sprite2D.texture = leftSprite
		walkerComponent.walkDirection = -1
	elif Input.is_action_pressed("Move Right") && !Input.is_action_pressed("Move Left"):
		sprite2D.texture = rightSprite
		walkerComponent.walkDirection = 1
	else:
		walkerComponent.walkDirection = 0

func handleJump():
	#wasOnFloor, coyoteTimer, isCoyoteState, isOnFloor (through signal), currentJumps, maxJumps, jumpQueued, canJump, jumpCooldownTimer
	if Input.is_action_just_pressed("Jump"):
		jumperComponent.start_jump()
	if Input.is_action_just_released("Jump"):
		jumperComponent.release_jump()
	if is_on_floor() != wasOnFloor:
		changeOnFloorState.emit(is_on_floor())
	wasOnFloor = is_on_floor()


func handleAim():
	weaponManager.aimPosition = get_global_mouse_position()

func handlePrimaryFire():
	if Input.is_action_pressed("Primary Fire"):
		weaponManager.fire_primary()
		
func handleSecondaryFire():
	if Input.is_action_pressed("Secondary Fire"):
		weaponManager.fire_secondary()

func handleTertiaryFire():
	if Input.is_action_pressed("Tertiary Fire"):
		weaponManager.fire_tertiary()

func handleWeaponSwap():
	if Input.is_action_just_pressed("SwapWeaponDown"):
		weaponManager.switch_weapon(weaponInventoryManager.swap_weapon_left())
	if Input.is_action_just_pressed("SwapWeaponUp"):
		weaponManager.switch_weapon(weaponInventoryManager.swap_weapon_right())
	selectedNewWeapon.emit(weaponInventoryManager.currentWeapon)
	
func handleWeaponDurability():
	if weaponManager.instantiatedWeapon != null:
		var durabilityPercentage = (float(weaponManager.instantiatedWeapon.durability) / float(weaponManager.instantiatedWeapon.maxDurability)) * 100
		durabilityChanged.emit(weaponInventoryManager.currentWeapon, durabilityPercentage)
	
func handleCraftingToggle():
	if Input.is_action_just_pressed("ToggleCraftingMenu"):

		craftingOpen = !craftingOpen
		changeCraftingMenuState.emit(craftingOpen)



# Later you should still be able to fire, but only if its outside the bounds
# of the crafting menu
func handleWeaponFiring():
	handleAim()
	if !craftingOpen:
		handlePrimaryFire()
		handleSecondaryFire()
		handleTertiaryFire()
	handleWeaponSwap()
	handleWeaponDurability()

func addToCrafting(resourceName: String):
	resourceInventoryManager.addResourceToCrafting(resourceName)
	ingredientsChanged.emit(resourceInventoryManager.resourcesInCrafting)
	
func removeFromCrafting(resourceName: String):
	resourceInventoryManager.subtractResourceFromCrafting(resourceName)
	ingredientsChanged.emit(resourceInventoryManager.resourcesInCrafting)
	
func resetCrafting():
	resourceInventoryManager.resetCrafting()
	ingredientsChanged.emit(resourceInventoryManager.resourcesInCrafting)

func startCrafting():
	print(resourceInventoryManager.resourcesInCrafting)
	print(resourceInventoryManager.getCraftingCount())
	if resourceInventoryManager.getCraftingCount() == 8:
		var item = craftingManager.craft(resourceInventoryManager.resourcesInCrafting)
		var itemScene = CSVManager.getItemScene(item)
		if itemScene != null:
			weaponInventoryManager.add_weapon(itemScene)
		weaponSlotChanged.emit(weaponInventoryManager.weapons.size() - 1, item)


func relayChangedHealth(newHealth: int):
	healthChanged.emit(newHealth)
	animationPlayer.play("iFrameFlashing")


func _on_resource_inventory_manager_resource_count_changed(resourceName: String, resourceCount: int):
	resourceCountChanged.emit(resourceName, resourceCount)
