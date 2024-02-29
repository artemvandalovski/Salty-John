class_name Hitbox
extends Area2D
"""
Area that can deal damage to Hurtboxes
"""

@onready var collision = $CollisionShape2D
var damage = 0


func _ready():
	config()


func config():
	collision.disabled = true
	collision_layer = 4
	collision_mask = 5
