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



func _process(delta):
	if _timer_text != null:
		_time += delta
		_timer_text.text = "Time: " + str(snapped(_time, 0.001))

func _on_area_2d_area_entered(area):
	_final_timer_text.text = "FINAL TIME: " + str(snapped(_time, 0.001))



func _on_player_health_changed(newHealth: int):
	_health_text.text = "Player Health: " + str(newHealth)
	if newHealth == 0:
		_death_text.visible = true


func _on_player_new_weapon_selected(newWeapon: int):
	_weapon_slots[_last_selected_weapon].modulate = _deselected_slot_color
	_weapon_slots[newWeapon].modulate = _selected_slot_color
	_last_selected_weapon = newWeapon


func _on_player_durability_changed(_current_weapon: int, durability: int):
	_weapon_slots[_current_weapon].get_child(2).value = durability

func _on_player_weapon_slot_changed(weaponSlot: int, weaponName: String):
	if weaponName == "":
		_weapon_slots[weaponSlot].get_child(1).texture = null
		_weapon_slots[weaponSlot].get_child(2).visible = false
		return
	_weapon_slots[weaponSlot].get_child(1).texture = (
			load("res://sprites/item_icons/" + CSVManager.get_item_icon(weaponName))
	)
	_weapon_slots[weaponSlot].get_child(2).visible = true

	
