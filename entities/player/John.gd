extends CharacterBody2D

const FRICTION = 0.8
const SPEED = 100.0

var health = 5


func _ready():
	Global.player = self


func _process(delta):
	pass


func _physics_process(delta):
	handle_movement()


func handle_movement():
	var movement_input = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	var acceleration = movement_input * SPEED
	velocity += acceleration
	velocity *= FRICTION
	move_and_slide()
