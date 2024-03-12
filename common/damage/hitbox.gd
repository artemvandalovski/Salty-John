class_name Hitbox
extends Area2D
"""
Area that can deal damage to Hurtboxes
"""

@onready var collision = $CollisionShape2D

@export var damage = 1


func _ready():
	config()


func config():
	#collision.disabled = true
	collision_layer = 8
	collision_mask = 16
