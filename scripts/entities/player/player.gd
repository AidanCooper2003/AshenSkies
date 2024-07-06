class_name Player

extends CharacterBody2D

signal on_floor_state_changed
signal health_changed
signal new_weapon_selected
signal durability_changed
signal crafting_menu_state_changed
signal resource_count_changed
signal ingredients_changed
signal weapon_slot_changed

@export var _left_sprite: Texture
@export var _right_sprite: Texture

var _can_jump := true
var _was_on_floor: bool
var _crafting_open := false

@onready var _walker_component := $WalkerComponent
@onready var _jumper_component := $JumperComponent
@onready var _weapon_manager := $WeaponManager
@onready var _animation_player := $AnimationPlayer
@onready var _weapon_inventory_manager := $WeaponInventoryManager
@onready var _resource_inventory_manager := $ResourceInventoryManager
@onready var _crafting_manager := $CraftingManager
@onready var _sprite_2d := $Sprite2D

func _physics_process(_delta) -> void:
	_handle_walk()
	_handle_jump()
	_handle_weapon_firing()
	move_and_slide()
	_handle_crafting_toggle()


func add_to_crafting(resource_name: String) -> void:
	_resource_inventory_manager.increment_ingredient(resource_name)
	_update_ingredients()


func remove_from_crafting(resource_name: String) -> void:
	_resource_inventory_manager.decrement_ingredient(resource_name)
	_update_ingredients()


func reset_ingredients() -> void:
	_resource_inventory_manager.reset_ingredients()
	_update_ingredients()


func start_crafting() -> void:
	if _resource_inventory_manager.get_ingredient_count() == 8:
		var weapon = _crafting_manager.craft(_resource_inventory_manager.ingredients)
		var weapon_scene = CSVManager.get_weapon_scene(weapon)
		if weapon_scene != null:
			_weapon_inventory_manager.add_weapon(weapon_scene)
		weapon_slot_changed.emit(_weapon_inventory_manager.weapons.size() - 1, weapon)


func _handle_walk() -> void:
	if Input.is_action_pressed("Move Left") and not Input.is_action_pressed("Move Right"):
		_sprite_2d.texture = _left_sprite
		_walker_component.walk_direction = -1
	elif Input.is_action_pressed("Move Right") and not Input.is_action_pressed("Move Left"):
		_sprite_2d.texture = _right_sprite
		_walker_component.walk_direction = 1
	else:
		_walker_component.walk_direction = 0


func _handle_jump() -> void:
	if Input.is_action_just_pressed("Jump"):
		_jumper_component.start_jump()
	if Input.is_action_just_released("Jump"):
		_jumper_component.release_jump()
	if is_on_floor() != _was_on_floor:
		on_floor_state_changed.emit(is_on_floor())
	_was_on_floor = is_on_floor()


func _handle_aim() -> void:
	_weapon_manager.aim_position = get_global_mouse_position()


func _handle_primary_fire() -> void:
	if Input.is_action_pressed("Primary Fire"):
		_weapon_manager.fire_primary()


func _handle_secondary_fire() -> void:
	if Input.is_action_pressed("Secondary Fire"):
		_weapon_manager.fire_secondary()


func _handle_tertiary_fire() -> void:
	if Input.is_action_pressed("Tertiary Fire"):
		_weapon_manager.fire_tertiary()


func _handle_weapon_swap() -> void:
	if Input.is_action_just_pressed("SwapWeaponDown"):
		_weapon_manager.switch_weapon(_weapon_inventory_manager.swap_weapon_left())
	if Input.is_action_just_pressed("SwapWeaponUp"):
		_weapon_manager.switch_weapon(_weapon_inventory_manager.swap_weapon_right())
	new_weapon_selected.emit(_weapon_inventory_manager._current_weapon)


func _handle_weapon_durability() -> void:
	if _weapon_manager.instantiated_weapon != null:
		var durability_percentage := (
				float(_weapon_manager.instantiated_weapon.durability) / 
				float(_weapon_manager.instantiated_weapon.max_durability)) * 100
		durability_changed.emit(_weapon_inventory_manager._current_weapon, durability_percentage)


func _handle_crafting_toggle() -> void:
	if Input.is_action_just_pressed("ToggleCraftingMenu"):
		_crafting_open = not _crafting_open
		crafting_menu_state_changed.emit(_crafting_open)


#Later you should still be able to fire, but only if its outside the bounds
#of the crafting menu
func _handle_weapon_firing() -> void:
	_handle_aim()
	if not _crafting_open:
		_handle_primary_fire()
		_handle_secondary_fire()
		_handle_tertiary_fire()
	_handle_weapon_swap()
	_handle_weapon_durability()

func _update_ingredients() -> void:
	ingredients_changed.emit(_resource_inventory_manager.ingredients)

func _on_changed_health(newHealth: int) -> void:
	health_changed.emit(newHealth)
	_animation_player.play("iFrameFlashing")


func _on_resource_count_changed(resource_name: String, resource_count: int) -> void:
	resource_count_changed.emit(resource_name, resource_count)
