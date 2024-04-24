class_name Enemy
extends CharacterBody2D

const FRICTION = 0.85
const SPEED = 40

@export var health := 3
@export var mass := 1

@onready var label = $Label
@onready var nav_agent = $NavigationAgent2D
@onready var context_steering = $ContextSteering

@onready var player: Node2D = Global.player


func _ready():
	update_label()

func take_damage(dmg: int):
	health -= dmg
	update_label()
	if health <= 0:
		queue_free()

func take_knockback(kb: Vector2):
	velocity += kb / mass

func update_label():
	label.text = str(health) + "HP"


func _on_breadcrumb_component_breadcrumb_hit():
	$StateMachine.switch_states($StateMachine/Idle)
