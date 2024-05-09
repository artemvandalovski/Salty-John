class_name Patrol
extends State

@export var max_distance: float = 300.0
@export var min_distance: float = 200.0
@export var target_radius: float = 100.0

@export var context_steerer: ContextSteerer
@export var player_tracker: PlayerTracker


func _ready():
	assert(context_steerer != null, "Please set the context_steerer node")
	assert(player_tracker != null, "Please set the player_tracker node")

func enter():
	set_patrol_point()

func process(delta):
	owner.direction = context_steerer.calc_steering()
	if player_tracker.is_player_on_sight():
		transition.emit("chase")
	elif owner.position.distance_to(context_steerer.target_marker.position) < target_radius:
		transition.emit("idle")


## Random but also influenced by the player position
func set_patrol_point():
	var rand_radian = randf_range(0, TAU)
	var rand_direction = Vector2.from_angle(rand_radian)
	
	var player_pos = to_local(Global.player.global_position)
	var dot_product = rand_direction.dot(player_pos)
	var interest = clamp(dot_product, 0.5, 1.0)
	
	var distance = position.distance_to(player_pos)
	distance = clamp(distance, min_distance, max_distance)
	
	var patrol_point = global_position + (rand_direction * interest) * distance
	context_steerer.target_marker.set_position(patrol_point)
