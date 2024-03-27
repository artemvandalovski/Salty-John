class_name Enemy
extends CharacterBody2D

const FRICTION = 0.85

const speed = 200

@export var health := 3
@export var mass := 1

@onready var label = $Label
@onready var nav_agent = $NavigationAgent2D

@onready var player: Node2D = Global.player

func _ready():
	update_label()

func _physics_process(delta):
	handle_movement()

func update_label():
	label.text = str(health) + "HP"

func handle_movement():
	#make_path()
	#var dir = to_local(nav_agent.get_next_path_position()).normalized()
	#velocity = dir * speed
	velocity *= FRICTION
	move_and_slide()

func take_damage(dmg: int):
	health -= dmg
	update_label()
	if health <= 0:
		queue_free()

func take_knockback(kb: Vector2):
	velocity += kb / mass

func make_path():
	nav_agent.target_position = player.global_position
