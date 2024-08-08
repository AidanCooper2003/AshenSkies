class_name ConditionHandler

extends Node2D

var conditions: Dictionary

#A condition has
#Key: Name of Condition
#Time Left
#Modifications (Dictionary, key is type, amount is value)
#Modication Type
#Modification Amount (-0.1 for 10% reduction, 0.1 for 10% increase)
#If it is a boolean for active/inactive, each 1 will increase the effect to some maximum amount.
#Negatives could have certain effects for some modifications

func _physics_process(delta) -> void:
	if not conditions.is_empty():
		for condition in conditions:
			conditions[condition]["time"] -= delta
			if conditions[condition]["time"] <= 0:
				conditions.erase(condition)


func add_condition(condition_name: String, time: float) -> void:
	print(conditions)
	if not conditions.has(condition_name):
		var modifications := CSVManager.get_condition_modifications(condition_name)
		conditions[condition_name] = modifications
	elif conditions[condition_name]["time"] > time:
		return
	conditions[condition_name]["time"] = time



func get_modification(modification_name: String) -> float:
	var change_amount := 0.0
	for condition in conditions:
		if conditions[condition].has(modification_name):
			change_amount += conditions[condition][modification_name]
	return change_amount


func has_modification(modification_name: String) -> float:
	for condition in conditions:
		if conditions[condition].has(modification_name):
			return true
	return false
