class_name Hitbox
extends Area2D
"""
Area that can deal damage to Hurtboxes
"""

@export var damage := 1


func _ready():
	config()


func config():
	collision_layer = 4
	collision_mask = 5
