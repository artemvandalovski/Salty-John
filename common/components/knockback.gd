class_name Knockback
extends Node2D

@export var strength = 200
@export var min_knockback = 100

func get_knockback() -> Vector2:
	return Vector2.ZERO
