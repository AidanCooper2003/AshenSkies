extends Node2D

@export var timerText: RichTextLabel
@export var finalTimerText: RichTextLabel
@export var healthText: RichTextLabel
@export var deathText: RichTextLabel

@export var deselectedSlotColor: Color
@export var selecectedSlotColor: Color

@export var weaponSlots: Array[Control]

var lastSelectedWeapon = 0

var time: float = 0



func _process(delta):
	if timerText != null:
		time += delta
		timerText.text = "Time: " + str(snapped(time, 0.001))

func _on_area_2d_area_entered(area):
	finalTimerText.text = "FINAL TIME: " + str(snapped(time, 0.001))


func _on_player_health_changed(newHealth: int):
	healthText.text = "Player Health: " + str(newHealth)
	if newHealth == 0:
		deathText.visible = true


func _on_player_selected_new_weapon(newWeapon: int):
	weaponSlots[lastSelectedWeapon].modulate = deselectedSlotColor
	weaponSlots[newWeapon].modulate = selecectedSlotColor
	lastSelectedWeapon = newWeapon


func _on_player_durability_changed(currentWeapon: int, durability: int):
	weaponSlots[currentWeapon].get_child(2).value = durability
