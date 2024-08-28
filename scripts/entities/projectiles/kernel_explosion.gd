class_name KernelExplosion

extends Node2D

func _ready():
	$AnimationPlayer.play("explosion_grow")
	print(name)
	
	for area in $DamageDealerComponent.get_overlapping_areas():
		print(area)
		$DamageDealerComponent._on_area_entered(area)


func _on_animation_player_animation_finished(anim_name):
	queue_free()
