##Handles events not handled entirely in a packed scene.
##Make sure to, in any ready function, call_deferred if the actions require a connected signal.
extends Node

#From Player
signal player_health_changed
signal durability_changed
signal active_slot_changed
signal weapon_in_slot_changed
signal resource_count_changed
signal ingredients_changed
signal crafting_menu_state_changed

#From UI
signal ingredient_selected
signal ingredients_reset
signal ingredient_deselected
signal crafting_started
