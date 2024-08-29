class_name MenuManager

extends Node

var _recipe_tags : Dictionary
var _recipe_qualities : Dictionary

func _ready():
	_initialize_grimoire()
	_recipe_tags = CSVManager.get_tags(CSVManager.recipes, 0, 1)
	_recipe_qualities = CSVManager.get_properties(CSVManager.recipes, 0, 2)

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/game.tscn")


func _initialize_grimoire():
	for recipe in CSVManager.get_weapon_names():
		var grimoire_entry = load("res://scenes/ui/elements/grimoire_entry.tscn").instantiate()
		var grimoire_texture_rect = grimoire_entry.get_child(0)
		grimoire_entry.get_child(0).texture = load(CSVManager.get_weapon_icon(recipe))
		var weapon_count = SaveManager.retrieve_save_data(recipe + "_count")
		if weapon_count != null && weapon_count > 0:
			grimoire_texture_rect.modulate = Color.WHITE
		grimoire_entry.pressed.connect(_update_stats.bind(recipe))
		$Grimoire/VBoxContainer/IconGrid.add_child(grimoire_entry)


func _on_exit_button_pressed():
	get_tree().quit()


func _on_grimoire_button_pressed():
	$Camera2D.position = Vector2(2880, 540)


func _on_return_button_pressed():
	$Camera2D.position = Vector2(960, 540)


func _update_stats(weapon_name: String):
	var times_crafted = 0
	if SaveManager.has_save_data(weapon_name + "_count"):
		times_crafted = "Times crafted: " + str(SaveManager.retrieve_save_data(weapon_name + "_count"))
	else:
		return
	var tags = _recipe_tags[weapon_name]
	var quality = _recipe_qualities[weapon_name]
	$Grimoire/VBoxContainer/Stats.text = (
		"Weapon Name: " + weapon_name + "\n"
		+ "Times Crafted: " + str(times_crafted) + "\n"
		+ "Tags: " + str(tags) + "\n"
		+ "Quality: " + str(quality)
	)


func _on_settings_pressed():
	$Camera2D.position = Vector2(960, 1620)
