class_name Draggable
extends RigidBody2D

@export var spin_force = 0
@export var velocity_treshhold = 125.0

func take_knockback(kb: Vector2):
	apply_torque_impulse(kb.length() * randi_range(-2, 2) * spin_force)
	apply_impulse(kb / mass)

func get_knockback():
	if !is_fast_enough():
		return Vector2.ZERO
	var kb = linear_velocity
	linear_velocity *= -physics_material_override.bounce
	return kb

func is_fast_enough() -> bool:
	return linear_velocity.length_squared() > pow(velocity_treshhold, 2)
