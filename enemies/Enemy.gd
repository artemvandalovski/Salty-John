class_name Enemy
extends CharacterBody2D

const FRICTION = 0.8

@export var health := 3
@export var mass := 1


func _physics_process(delta):
	handle_movement()


func handle_movement():
	velocity *= FRICTION
	move_and_slide()

func take_damage(dmg: int):
	health -= dmg
	if health <= 0:
		pass

func take_knockback(kb: Vector2):
	velocity += kb / mass
