class_name HealthComponent

extends Node2D

signal health_changed(new_health: int, trigger_on_damage: bool)

const simple_damage_over_time_coefficient = 2

@export var _max_health : int
@export var _simple_health : bool
@export var damage_over_time_delay := 0.1
@export var damage_resistance := 1.0
@export var iframe_length : float


var _current_health : int
var _condition_handler: ConditionHandler
var _time_since_tick_damage: float
var _accumulated_simple_tick_damage: float
var _no_current_damage_over_time := true
var iframe_start_time : float

func _ready() -> void:
	_current_health = _max_health
	health_changed.emit(_current_health, false)
	await owner.ready
	_condition_handler = owner.get_node("ConditionHandler")


func _physics_process(delta):
	if _condition_handler == null || not _condition_handler.has_modification("damage_over_time"):
		_no_current_damage_over_time = true
		_accumulated_simple_tick_damage = 0
		if get_parent().name == "Player":
			EventBus.accumulated_damage.emit(0)
		return
	if _simple_health:
		_handle_simple_damage_over_time(delta)
	else:
		_handle_damage_over_time(delta)



func take_damage(damage : int, resistance_override : bool) -> void:
	if not resistance_override && Time.get_ticks_msec() < iframe_length * 1000 + iframe_start_time:
		return
	var resistance := damage_resistance
	var will_dodge := false
	if resistance_override:
		resistance = 1
	var rand = randf()
	if randf() <= _condition_handler.get_modification("dodge") and not resistance_override:
		will_dodge = true
	elif not _simple_health:
		_current_health = clampi(_current_health - damage * resistance, 0, _max_health)
	else:
		_current_health -= ceil(float(damage) / 100.0)
		iframe_start_time = Time.get_ticks_msec()
	_current_health = clamp(_current_health, 0, INF)
	health_changed.emit(_current_health, true)
	if _current_health <= 0:
		die()


func change_health(health : int) -> void:
	_current_health = clampi(_current_health + health, 0, _max_health)
	health_changed.emit(_current_health, false)


func die() -> void:
	get_parent().queue_free()


func get_at_max_health() -> bool:
	return _max_health == _current_health


func _on_hitbox_component_damage_taken(damageAmount) -> void:
	take_damage(damageAmount, false)
	
func _handle_simple_damage_over_time(delta: float) -> void:
	var damage_over_time = _condition_handler.get_modification("damage_over_time")
	_accumulated_simple_tick_damage += delta * damage_over_time * simple_damage_over_time_coefficient
	if _accumulated_simple_tick_damage >= 100:
		_accumulated_simple_tick_damage = 0
		take_damage(1, false)
	#TODO Change this
	if get_parent().name == "Player":
		EventBus.accumulated_damage.emit(_accumulated_simple_tick_damage)

func _handle_damage_over_time(delta: float) -> void:
	if _no_current_damage_over_time:
		_time_since_tick_damage = damage_over_time_delay
		_no_current_damage_over_time = false
	var damage_over_time = _condition_handler.get_modification("damage_over_time")
	_time_since_tick_damage += delta
	if _time_since_tick_damage > damage_over_time_delay:
		take_damage(damage_over_time, true)
		_time_since_tick_damage = 0
