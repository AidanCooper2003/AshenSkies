extends Node

var save := {}

func _ready():
	load_save()


func reset_save():
	save = {}
	save_game()
	

func retrieve_save_data(key: String) -> Variant:
	if save.has(key):
		return save[key]
	return null


func add_save_data(key: String, value) -> void:
	save[key] = value
	save_game()

func has_save_data(key) -> bool:
	return save.has(key)


func save_game() -> void:
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save)
	save_file.store_line(json_string)


func load_save() -> void:
	if not FileAccess.file_exists("user://savegame.save"):
		return
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json = JSON.new()
	var parse_result = json.parse(save_file.get_line())
	if not parse_result == OK:
		print("save error")
		return
	var node_data = json.get_data()
	save = node_data
