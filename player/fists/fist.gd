extends Weapon

const PUNCH_DEPTH = 16 # how far the fists will go for a punch
const CHARGE_DEPTH = 8 # how far the fists will go back while charging
const CHARGE_RATE = 2
const MAX_CHARGE = -1
const COOLDOWN = 0.07

@export_enum("left_click", "right_click") var input: String

@onready var hitbox = $Hitbox
@onready var knockback_component = $Knockback
@onready var dragging_raycast = $Dragging

var charge = 0.0


func _process(delta):
	handle_charge(delta)
	handle_punch(delta)


func handle_charge(delta):
	if Input.is_action_pressed(input):
		handle_dragging()
		charge = max(charge - CHARGE_RATE * delta, MAX_CHARGE)
		position.x = charge * CHARGE_DEPTH

func handle_punch(delta):
	if Input.is_action_just_released(input):
		punch()

func punch():
	hitbox.collision.disabled = false
	var punch_tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	punch_tween.tween_property(self, 'position:x', charge + PUNCH_DEPTH, 0.1)
	punch_tween.tween_property(self, 'position:x', 0, COOLDOWN)
	await punch_tween.finished
	hitbox.collision.disabled = true
	charge = 0.0

func get_knockback() -> Vector2:
	var power = charge * -1
	var strength = knockback_component.strength
	var min_knockback = knockback_component.min_knockback
	var velocity = owner.holder.velocity
	var direction = Vector2(cos(global_rotation), sin(global_rotation))
	var knockback = velocity + (direction * max(strength * power, min_knockback))
	return knockback

func handle_dragging():
	if !dragging_raycast.is_colliding(): return
	var draggable_object: RigidBody2D = dragging_raycast.get_collider().owner
	draggable_object.global_position = lerp(draggable_object.global_position, global_position, 0.05)
