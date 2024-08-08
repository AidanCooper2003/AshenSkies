class_name Weapon

extends Node2D

signal weapon_broke()

signal self_damage_triggered(damage: int)
signal health_change_triggered(health: int)
signal condition_added(condition: String, time: float)

@export var max_durability: int
@export var _fire_delay: float
@export var weapon_name: String

#Note: The node should still work even if this isn't assigned, just be missing
#functionality that requires it.
var character: Node2D

var _can_fire := false
var _enabled := false

@onready var _fire_delay_timer := $FireDelayTimer
@onready var sprite := $Sprite2D
@onready var durability := max_durability

func _ready() -> void:
	_fire_delay_timer.connect("timeout", _on_fire_delay_timer_timeout)
	_fire_delay_timer.wait_time = _fire_delay
	_fire_delay_timer.start()
	disable()


func fire_primary(weapon_angle: Vector2) -> bool:
	return false


func fire_secondary(weapon_angle: Vector2) -> bool:
	return false


func fire_tertiary(weapon_angle: Vector2) -> bool:
	return false


func set_sprite_right() -> void:
	scale = Vector2(1, -1)


func set_sprite_left() -> void:
	scale = Vector2(1, 1)


func enable() -> void:
	_enabled = true
	sprite.visible = true
	_can_fire = false
	_fire_delay_timer.start()


func disable() -> void:
	_enabled = false
	sprite.visible = false


func get_enabled() -> bool:
	return _enabled


func get_character_node(node_type: String) -> Node2D:
	if character == null:
		return null
	for node in character.get_children():
		if NodeHelper.is_instance_of_string(node, node_type):
			return node
	return null

func _on_fire_delay_timer_timeout() -> void:
	_can_fire = true
