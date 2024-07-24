extends Node

var _resource_odds: Dictionary

func _ready():
	_set_resource_odds()
	print(_resource_odds)

#Currently ignores weights since its not yet needed
func choose_random_resource() -> String:
	var choice = randi_range(0, _resource_odds.size() - 1)
	print(choice)
	return _resource_odds.keys()[choice]

func _set_resource_odds() -> void:
	var resource_names = CSVManager.get_resource_names()
	var resource_count = resource_names.size()
	for resource in CSVManager.get_resource_names():
		_resource_odds[resource] = 1.0 / float(resource_count)
