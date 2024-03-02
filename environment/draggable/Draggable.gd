class_name Draggable
extends RigidBody2D

@export var spin_force = 0


func take_knockback(kb: Vector2):
	apply_torque_impulse(kb.length() * randi_range(-2, 2) * spin_force)
	apply_impulse(kb / mass)
