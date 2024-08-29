class_name JumperComponent

extends Node2D

@export var _character_body_2d: CharacterBody2D
@export var _jump_force: float
@export var _jump_delay: float
@export var _gravity_component: GravityComponent
@export var _max_jumps: int

var _current_jumps: int
var _was_on_floor: bool
var _is_coyote_state: bool
var _is_on_floor: bool
var _jump_queued: bool
var _can_jump := true
var _coyote_timer: Timer
var _jump_cooldown_timer: Timer
var _jump_queue_timer: Timer
var _condition_handler: ConditionHandler
var _jump_speed_modifier := 0.5

func _ready() -> void:
	_jump_cooldown_timer = get_child(0)
	_jump_cooldown_timer.wait_time = _jump_delay
	_coyote_timer = get_child(1)
	_jump_queue_timer = get_child(2)
	_condition_handler = owner.get_node("ConditionHandler")


func _physics_process(delta) -> void:
	#Handle Coyote
	if not _is_on_floor and _was_on_floor:
		_coyote_timer.start()
		_is_coyote_state = true
	_was_on_floor = _is_on_floor
	#Handle Jump Replenishment
	if _is_on_floor and _current_jumps < _max_jumps:
		_current_jumps = _max_jumps
	if _jump_queued:
		start_jump()


func force_jump() -> void:
	var speed_modifier := 1.0
	if _condition_handler.has_modification("speed") * _jump_speed_modifier:
		speed_modifier *= _condition_handler.get_modification("speed")
	_character_body_2d.velocity.y = -_jump_force * _condition_handler.get_modification("speed")
	_gravity_component.fast_fall_override = false


func start_jump() -> void:
	if _can_jump and _current_jumps >= 1:
		_jump()


func release_jump() -> void:
	_gravity_component.fast_fall_override = true


func _jump() -> void:
	var speed_modifier := 1.0
	if _condition_handler.has_modification("speed"):
		print(_condition_handler.get_modification("speed"))
		print(1 + ((_condition_handler.get_modification("speed")) * _jump_speed_modifier))
		speed_modifier *= (1 + (((_condition_handler.get_modification("speed"))) * _jump_speed_modifier))
	_character_body_2d.velocity.y = -_jump_force * speed_modifier
	_gravity_component.fast_fall_override = false
	if not _is_on_floor and not _is_coyote_state:
		_current_jumps -= 1
	_can_jump = false
	_jump_cooldown_timer.start()
	if _jump_queued:
		_jump_queued = false
	else:
		_jump_queue_timer.start()


func _on_character_change_on_floor_state(newFloorState) -> void:
	_is_on_floor = newFloorState


func _on_jump_cooldown_timer_timeout() -> void:
	_can_jump = true


func _on_coyote_timer_timeout() -> void:
	_is_coyote_state = false


func _on_jump_queue_timer_timeout() -> void:
	_jump_queued = false
