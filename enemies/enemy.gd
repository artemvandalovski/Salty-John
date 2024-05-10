class_name Enemy
extends CharacterBody2D

const FRICTION = 0.85

signal dead

@export var health := 3
@export var mass := 1
@export var hostile = false

@onready var state_machine = $StateMachine

@onready var health_label = $Health

var direction: Vector2
var speed: float = 40.0

func _ready():
	update_label()

func _physics_process(delta):
	velocity += direction * speed
	velocity *= FRICTION
	move_and_slide()


func take_damage(dmg: int):
	health -= dmg
	hostile = true
	update_label()
	if health <= 0:
		emit_signal("dead")
		queue_free()

func take_knockback(kb: Vector2):
	velocity += kb / mass

func update_label():
	health_label.text = str(health) + "HP"
