class_name UIManager

extends Node2D

@export var _timer_text: RichTextLabel
@export var _final_timer_text: RichTextLabel
@export var _health_text: RichTextLabel
@export var _death_text: RichTextLabel
@export var _conditions_text: RichTextLabel
@export var _accumulated_damage_text: RichTextLabel
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
	EventBus.player_conditions_changed.connect(_on_player_conditions_changed)
	EventBus.accumulated_damage.connect(_on_player_accumulated_damage)

func _on_area_2d_area_entered(area) -> void:
	if _final_timer_text == null:
		return
	_final_timer_text.text = "FINAL TIME: " + str(snapped(_time, 0.001))


func _on_player_health_changed(new_health: int) -> void:
	if _health_text == null:
		return
	if new_health == -1:
		_health_text.text = "Player Health: ???"
		return
	_health_text.text = "Player Health: " + str(new_health)
	if _death_text == null:
		return
	if new_health == 0:
		_death_text.visible = true


func _on_active_slot_changed(new_weapon: int) -> void:
	if (
			_weapon_slots == null
			or _weapon_slots.size() == 0 
			or _weapon_slots[_last_selected_weapon] == null 
			or _weapon_slots[new_weapon] == null
		):
		return
	_weapon_slots[_last_selected_weapon].modulate = _deselected_slot_color
	_weapon_slots[new_weapon].modulate = _selected_slot_color
	_last_selected_weapon = new_weapon


func _on_durability_changed(current_weapon: int, durability: int) -> void:
	if _weapon_slots[current_weapon] == null:
		return
	_weapon_slots[current_weapon].get_child(2).value = durability


func _on_weapon_in_slot_changed(weapon_slot: int, weapon_name: String) -> void:
	if _weapon_slots[weapon_slot] == null:
		return
	if weapon_name == "":
		_weapon_slots[weapon_slot].get_child(1).texture = null
		_weapon_slots[weapon_slot].get_child(2).visible = false
		return
	_weapon_slots[weapon_slot].get_child(1).texture = (
			load(CSVManager.get_weapon_icon(weapon_name))
	)
	_weapon_slots[weapon_slot].get_child(2).visible = true


func _on_player_conditions_changed(conditions: Dictionary) -> void:
	var condition_text := "" 
	for condition in conditions:
		condition_text = condition_text + condition + ": " + str(snapped(conditions[condition]["time"], 1)) + "\n"
	_conditions_text.text = condition_text
	
func _on_player_accumulated_damage(damage: float) -> void:
	if damage == 0:
		print("no damage")
		_accumulated_damage_text.text = ""
	else:
		_accumulated_damage_text.text = "-" + str(snapped(damage / 100.0, 0.01))
	
