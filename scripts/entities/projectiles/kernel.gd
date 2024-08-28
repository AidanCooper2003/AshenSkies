class_name Kernel

extends RigidBody2D

@export var _explosive : PackedScene
@export var _mega_explosive: PackedScene

func _on_timer_timeout():
	_explode(false)


func _explode(is_mega_explosion: bool):
	print("Explode!" + str(is_mega_explosion))
	var kernel_explosion
	if is_mega_explosion:
		kernel_explosion = _mega_explosive.instantiate()
	else:
		kernel_explosion = _explosive.instantiate()
	get_tree().current_scene.add_child(kernel_explosion)
	kernel_explosion.position = position
	queue_free()


func _on_condition_handler_condition_added(condition_name):
	if condition_name == "burning":
		_explode(true)
