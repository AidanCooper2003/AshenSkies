extends Node2D

class_name JumperComponent

@export var characterBody2D: CharacterBody2D

@export var jumpForce: float

@export var jumpStopGap: float

@export var gravityComponent: GravityComponent


func jump():
	characterBody2D.velocity.y = -jumpForce
	gravityComponent.fastFallOverride = false

func jump_release():
	gravityComponent.fastFallOverride = true
