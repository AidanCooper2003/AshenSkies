extends Node

var _resource_odds: Dictionary
var _resource_category_counts: Dictionary
var _resource_category_odds: Dictionary
var _chosen_resources: Dictionary

func _ready():
	setup_resources()
	EventBus.level_changed.connect(setup_resources)


func setup_resources():
	_set_resource_category_counts()
	_set_resource_category_odds()
	_assign_resources_to_categories()


#Currently ignores weights
func choose_random_resource() -> String:
	var category_selection = randf()
	var accumulator = 0.0
	for category in _resource_category_odds:
		accumulator += _resource_category_odds[category]
		if category_selection <= accumulator:
			return _chosen_resources[category].pick_random()
	return ""


func _assign_resources_to_categories() -> void:
	var types = CSVManager.get_types_of_resources()
	for type in types:
		_chosen_resources[type] = []
		for i in range(_resource_category_counts[type]):
			_chosen_resources[type].append(types[type][randi_range(0, types[type].size() - 1)])
	

func _set_resource_category_counts() -> void:
	_resource_category_counts["single_form"] = 3
	_resource_category_counts["single_element"] = 2
	_resource_category_counts["single_mechanic"] = 1
	_resource_category_counts["double_element"] = 1
	_resource_category_counts["double_mixed"] = 1


func _set_resource_category_odds() -> void:
	_resource_category_odds["single_form"] = .25
	_resource_category_odds["single_element"] = .30
	_resource_category_odds["single_mechanic"] = .20
	_resource_category_odds["double_element"] = .15
	_resource_category_odds["double_mixed"] = .10
