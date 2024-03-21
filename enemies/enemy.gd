class_name Enemy
extends CharacterBody2D

const FRICTION = 0.85

@export var health := 3
@export var mass := 1

@onready var label = $Label

func _ready():
	update_label()

func _physics_process(delta):
	handle_movement()

func update_label():
	label.text = str(health) + "HP"

func handle_movement():
	velocity *= FRICTION
	move_and_slide()

func take_damage(dmg: int):
	health -= dmg
	update_label()
	if health <= 0:
		queue_free()

func take_knockback(kb: Vector2):
	velocity += kb / mass
