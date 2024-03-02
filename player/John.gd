extends CharacterBody2D

const PUSH_FORCE: float = 5.0 # force for pushing rigibodies
const FRICTION = 0.8
const SPEED = 100.0

var health = 5

@onready var sprite = $Sprite2D


func _ready():
	Global.player = self


func _physics_process(delta):
	handle_movement()
	flip_sprite()


func handle_movement():
	var movement_input = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	var acceleration = movement_input * SPEED
	velocity += acceleration
	velocity *= FRICTION
	move_and_slide()

func flip_sprite():
	sprite.flip_h = get_local_mouse_position().x < 0.0

#func handle_rigibodies():
	#for i in get_slide_collision_count():
		#var c = get_slide_collision(i)
		#if c.get_collider() is RigidBody2D:
			#c.get_collider().apply_central_impulse(
				#-c.get_normal() * PUSH_FORCE / c.get_collider().mass)
