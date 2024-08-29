class_name MenuManager

extends Node

var _recipe_tags : Dictionary
var _recipe_qualities : Dictionary
var _resource_tags : Dictionary
var _resource_qualities : Dictionary

var confirm_available := false

func _ready() -> void:
	_initialize_grimoire()
	_initialize_settings()
	_recipe_tags = CSVManager.get_tags(CSVManager.recipes, 0, 1)
	_recipe_qualities = CSVManager.get_properties(CSVManager.recipes, 0, 2)
	_resource_tags = CSVManager.get_tags(CSVManager.resources, 0, 1)
	_resource_qualities = CSVManager.get_properties(CSVManager.resources, 0, 2)
	

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/game.tscn")


func _initialize_grimoire() -> void:
	for recipe in CSVManager.get_weapon_names():
		var grimoire_entry = load("res://scenes/ui/elements/grimoire_entry.tscn").instantiate()
		var grimoire_texture_rect = grimoire_entry.get_child(0)
		grimoire_entry.get_child(0).texture = load(CSVManager.get_weapon_icon(recipe))
		var weapon_count = SaveManager.retrieve_save_data(recipe + "_count")
		if weapon_count != null && weapon_count > 0:
			grimoire_texture_rect.modulate = Color.WHITE
		grimoire_entry.pressed.connect(_update_weapon_stats.bind(recipe))
		$Grimoire/VBoxContainer/TabContainer/WeaponGrid.add_child(grimoire_entry)
	$Grimoire/VBoxContainer/Stats.text = "Stats:"
	for resource in CSVManager.get_resource_names():
		var grimoire_entry = load("res://scenes/ui/elements/grimoire_entry.tscn").instantiate()
		var grimoire_texture_rect = grimoire_entry.get_child(0)
		print(CSVManager.get_resource_icon(resource))
		grimoire_entry.get_child(0).texture = load(CSVManager.get_resource_icon(resource))
		var resource_count = SaveManager.retrieve_save_data(resource + "_count")
		if resource_count != null && resource_count > 0:
			grimoire_texture_rect.modulate = Color.WHITE
		grimoire_entry.pressed.connect(_update_resource_stats.bind(resource))
		$Grimoire/VBoxContainer/TabContainer/ResourceGrid.add_child(grimoire_entry)
	
func _initialize_settings() -> void:
	if SaveManager.has_save_data("music_volume"):
		$Settings/VBoxContainer/PanelContainer/Panel/VolumeSlider.value = SaveManager.retrieve_save_data("music_volume")
	else:
		$Settings/VBoxContainer/PanelContainer/Panel/VolumeSlider.value = 50
	print(linear_to_db(0.5))

func _reset_grimoire() -> void:
	for child in $Grimoire/VBoxContainer/TabContainer/WeaponGrid.get_children():
		child.queue_free()
	for child in $Grimoire/VBoxContainer/TabContainer/ResourceGrid.get_children():
		child.queue_free()
	_initialize_grimoire()

func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_grimoire_button_pressed() -> void:
	$Camera2D.position = Vector2(2880, 540)


func _on_return_button_pressed() -> void:
	$Camera2D.position = Vector2(960, 540)
	_make_confirm_unavailable()
	


func _update_weapon_stats(weapon_name: String) -> void:
	var times_crafted = 0
	if SaveManager.has_save_data(weapon_name + "_count"):
		times_crafted = SaveManager.retrieve_save_data(weapon_name + "_count")
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


func _update_resource_stats(weapon_name: String) -> void:
	var times_obtained = 0
	if SaveManager.has_save_data(weapon_name + "_count"):
		times_obtained = SaveManager.retrieve_save_data(weapon_name + "_count")
	else:
		return
	var tags = _resource_tags[weapon_name]
	var quality = _resource_qualities[weapon_name]
	$Grimoire/VBoxContainer/Stats.text = (
		"Resource Name: " + weapon_name + "\n"
		+ "Times Obtained: " + str(times_obtained) + "\n"
		+ "Tags: " + str(tags) + "\n"
		+ "Quality: " + str(quality)
	)

func _on_settings_pressed() -> void:
	$Camera2D.position = Vector2(960, 1620)


func _on_reset_save_button_pressed() -> void:
	$Settings/VBoxContainer/ResetSaveButton.text = "Click button below to confirm."
	$Settings/ConfirmButton.visible = true
	$Settings/VBoxContainer/ResetSaveButton.disabled = true
	confirm_available = true
	SaveManager.add_save_data("music_volume", $Settings/VBoxContainer/PanelContainer/Panel/VolumeSlider.value)


func _make_confirm_unavailable() -> void:
	confirm_available = false
	$Settings/VBoxContainer/ResetSaveButton.disabled = false
	$Settings/ConfirmButton.visible = false
	$Settings/VBoxContainer/ResetSaveButton.text = "Reset Save Data"

func _on_confirm_button_pressed() -> void:
	if confirm_available:
		SaveManager.reset_save()
		_reset_grimoire()
		_make_confirm_unavailable()


func _on_h_slider_value_changed(value):
	SaveManager.add_save_data("music_volume", value)
	EventBus.music_volume_changed.emit()
