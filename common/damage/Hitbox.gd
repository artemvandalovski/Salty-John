class_name Hitbox
extends Area2D
"""
Area that can deal damage to Hurtboxes
"""

var damage = 0


func _ready():
	config()


func config():
	collision_layer = 4
	collision_mask = 5
	monitorable = false
