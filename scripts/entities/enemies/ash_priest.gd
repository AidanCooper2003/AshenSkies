class_name AshPriest

extends Node2D

var _target: Node2D

@onready var _weapon_manager := $WeaponManager
@onready var _animation_player := $AnimationPlayer

func _physics_process(delta) -> void:
	if _target != null:
		_weapon_manager.aim_position = _target.position
		_weapon_manager.fire_primary()


func _on_area_2d_body_entered(body) -> void:
	if body.name == "Player":
		_target = body


func _on_area_2d_body_exited(body) -> void:
	if body.name == "Player":
		_target = null


func _on_health_component_health_changed(_current_health: int, trigger_on_damage: bool) -> void:
	#Prevents a race condition with health's initial setting.
	if _animation_player == null:
		return
	if _animation_player.is_playing():
		_animation_player.stop()
		_animation_player.play("hurt")
		_animation_player.advance(0.06)
	_animation_player.play("hurt")
