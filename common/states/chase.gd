class_name Chase
extends State

var movement_func: Callable

@onready var context_steering = $"../../ContextSteering"

func _physics_process(delta):
	handle_movement()

func handle_movement():
	var direction = context_steering.calc_steering()
	owner.velocity += direction * owner.SPEED
	owner.velocity *= owner.FRICTION
	owner.move_and_slide()
