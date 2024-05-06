class_name Enemy
extends CharacterBody2D

const FRICTION = 0.85
const SPEED = 40

@export var health := 3
@export var mass := 1

@onready var context_steerer = $ContextSteerer
@onready var state_machine = $StateMachine

@onready var health_label = $Health

#var target = Global.player
var direction: Vector2


func _ready():
	update_label()
	
func _physics_process(delta):
	velocity += direction * SPEED
	velocity *= FRICTION
	move_and_slide()


func take_damage(dmg: int):
	health -= dmg
	update_label()
	if health <= 0:
		queue_free()

func take_knockback(kb: Vector2):
	velocity += kb / mass

func update_label():
	health_label.text = str(health) + "HP"


func _on_breadcrumb_component_breadcrumb_hit():
	var state: State = state_machine.current_state
	state.transition.emit("idle")
