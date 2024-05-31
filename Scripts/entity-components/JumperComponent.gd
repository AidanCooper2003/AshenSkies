extends Node2D

class_name JumperComponent

@export var characterBody2D: CharacterBody2D

@export var jumpForce: float


func jump():
	characterBody2D.velocity.y = -jumpForce
