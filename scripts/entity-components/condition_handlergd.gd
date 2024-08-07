class_name ConditionHandler

extends Node2D

var conditions: Dictionary

# A condition has
# Key: Name of Condition
# Time Left
# Modifications (Dictionary, key is type, amount is value)
# Modication Type
# Modification Amount (-0.1 for 10% reduction, 0.1 for 10% increase)
# If it is a boolean for active/inactive, each 1 will increase the effect to some maximum amount.
# Negatives could have certain effects for some modifications
