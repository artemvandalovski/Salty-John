class_name Draggable
extends RigidBody2D

@export var spin_force = 0
@export var velocity_treshhold = 400.0

@onready var hitbox = $Hitbox


func _ready():
	hitbox.knockback_func = calc_knockback
	hitbox.damage_func = calc_damage


func add_player_collisions():
	collision_mask = 7

func no_player_collisions():
	collision_mask = 5

func is_fast_enough() -> bool:
	return linear_velocity.length_squared() > pow(velocity_treshhold, 2)

func calc_damage(_hurtbox: Hurtbox):
	return floor(linear_velocity.length() / 100.0)

func calc_knockback(_hurtbox: Hurtbox) -> Vector2:
	var kb = linear_velocity
	return kb

func take_knockback(kb: Vector2):
	apply_torque_impulse(kb.length() * randi_range(-2, 2) * spin_force)
	apply_impulse(kb / mass)

func _on_hitbox_area_entered(hurtbox: Hurtbox):
	assert(hurtbox is Hurtbox)
	if is_fast_enough():
		hitbox.deal_damage()
	linear_velocity *= -physics_material_override.bounce
