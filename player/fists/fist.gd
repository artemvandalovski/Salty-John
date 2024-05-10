extends Weapon

const PUNCH_DEPTH = 16 # how far the fists will go for a punch
const CHARGE_DEPTH = 16 # how far the fists will go back while charging
const CHARGE_RATE = 2
const MAX_CHARGE = 2
const COOLDOWN = 0.07

const KNOCKBACK_STRENGTH: float = 300.0
const KNOCKBACK_MIN: float = 200.0

signal drag_started(node: Draggable)
signal drag_stopped(node: Draggable)

@export_enum("left_click", "right_click") var input: String

@onready var hitbox = $Hitbox
@onready var drag_raycast = $DragRayCast as RayCast2D
@onready var drag_center = $DragCenter

var dragging_node: Draggable = null
var charge = 0.0


func _ready():
	hitbox.knockback_func = calc_knockback
	hitbox.damage_func = calc_damage

func _physics_process(delta):
	handle_punch()
	handle_charge(delta)
	handle_drag()

func is_dragging() -> bool:
	return dragging_node != null
	
func start_draggin():
	dragging_node = drag_raycast.get_collider().owner
	dragging_node.no_player_collisions()
	drag_started.emit(dragging_node)
	
func stop_dragging():
	dragging_node.linear_velocity = owner.holder.velocity
	dragging_node.add_player_collisions()
	drag_stopped.emit(dragging_node)
	dragging_node = null

func handle_drag():
	if Input.is_action_just_pressed(input):
		if drag_raycast.is_colliding():
			start_draggin()
	
	if !Input.is_action_pressed(input) and dragging_node != null:
		stop_dragging()
		
	if is_dragging():
		dragging_node.global_position = lerp(
			dragging_node.global_position,
			drag_center.global_position, 0.2
		)

func handle_charge(delta):
	if Input.is_action_pressed(input):
		charge = minf(charge + CHARGE_RATE * delta, MAX_CHARGE)
		if !is_dragging():
			position.x = -CHARGE_DEPTH * (charge / MAX_CHARGE)

func handle_punch():
	if Input.is_action_just_released(input):
		punch()

func punch():
	var punch_tween: Tween = create_tween()\
		.set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	punch_tween.tween_property(self, 'position:x', charge + PUNCH_DEPTH, 0.1)
	punch_tween.tween_callback(hitbox.deal_damage) # <-- DAMAGE IS DEALT HERE
	punch_tween.tween_property(self, 'position:x', 0, COOLDOWN)
	
	await punch_tween.finished
	charge = 0.0

func calc_damage(_hurtbox: Hurtbox):
	var velocity: Vector2 = owner.holder.velocity
	return ceil(velocity.normalized().length() * charge)

func calc_knockback(_hurtbox: Hurtbox) -> Vector2:
	var velocity = owner.holder.velocity
	var direction = Vector2.from_angle(global_rotation)
	var knockback = velocity + (direction * max(KNOCKBACK_STRENGTH * charge, KNOCKBACK_MIN))
	return knockback
