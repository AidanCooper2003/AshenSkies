##Handles events not handled entirely in a packed scene.
##Make sure to, in any ready function, call_deferred if the actions require a connected signal.
extends Node

#From Player
signal player_health_changed(health: int)
signal durability_changed(slot: int, durability_percentage: float)
signal active_slot_changed(slot_index: int)
signal weapon_in_slot_changed(slot: int, weapon_name: String)
signal resource_count_changed(resource_name: String, resource_count: int)
signal ingredients_changed(ingredients: Dictionary)
signal crafting_menu_state_changed(crafting_open: bool)
signal player_conditions_changed(conditions: Dictionary)
signal accumulated_damage(damage: float)


#From UI
signal ingredient_selected(ingredient_name: String)
signal ingredients_reset()
signal ingredient_deselected()
signal crafting_started()


#From Level Objects
signal resource_added(resource_name: String, resource_count: int)
signal resource_subtracted(resource_name: String, resource_count: int)


# From Game
signal level_changed()


# From Settings
signal music_volume_changed()
