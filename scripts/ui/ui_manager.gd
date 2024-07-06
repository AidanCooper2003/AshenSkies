class_name UIManager

extends Node2D

@export var _timer_text: RichTextLabel
@export var _final_timer_text: RichTextLabel
@export var _health_text: RichTextLabel
@export var _death_text: RichTextLabel
@export var _deselected_slot_color: Color
@export var _selected_slot_color: Color
@export var _weapon_slots: Array[Control]

var _last_selected_weapon := 0
var _time: float = 0.0

func _ready():
	_setup_signals()


func _process(delta) -> void:
	if _timer_text != null:
		_time += delta
		_timer_text.text = "Time: " + str(snapped(_time, 0.001))

func _setup_signals():
	EventBus.player_health_changed.connect(_on_player_health_changed)
	EventBus.durability_changed.connect(_on_durability_changed)
	EventBus.active_slot_changed.connect(_on_active_slot_changed)
	EventBus.weapon_in_slot_changed.connect(_on_weapon_in_slot_changed)

func _on_area_2d_area_entered(area) -> void:
	_final_timer_text.text = "FINAL TIME: " + str(snapped(_time, 0.001))


func _on_player_health_changed(new_health: int) -> void:
	_health_text.text = "Player Health: " + str(new_health)
	if new_health == 0:
		_death_text.visible = true


func _on_active_slot_changed(new_weapon: int) -> void:
	_weapon_slots[_last_selected_weapon].modulate = _deselected_slot_color
	_weapon_slots[new_weapon].modulate = _selected_slot_color
	_last_selected_weapon = new_weapon


func _on_durability_changed(current_weapon: int, durability: int) -> void:
	_weapon_slots[current_weapon].get_child(2).value = durability


func _on_weapon_in_slot_changed(weapon_slot: int, weapon_name: String) -> void:
	if weapon_name == "":
		_weapon_slots[weapon_slot].get_child(1).texture = null
		_weapon_slots[weapon_slot].get_child(2).visible = false
		return
	_weapon_slots[weapon_slot].get_child(1).texture = (
			load("res://sprites/weapon_icons/" + CSVManager.get_weapon_icon(weapon_name))
	)
	_weapon_slots[weapon_slot].get_child(2).visible = true
