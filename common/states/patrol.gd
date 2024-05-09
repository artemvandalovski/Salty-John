class_name Patrol
extends State

@export var max_distance: float = 300.0
@export var min_distance: float = 200.0

@export var target: Marker2D
@export var target_tracker: TargetTracker

func _ready():
	assert(target_tracker != null, "Please set the target_tracker node")

func enter():
	pass

func process(delta):
	while !target_tracker.is_target_on_sight:
		set_patrol_position()
	owner.direction = global_position.direction_to(target.global_position)


## Random but also influenced by the player position
func set_patrol_position():
	var rand_radian = randf_range(0, TAU)
	var rand_direction = Vector2.from_angle(rand_radian)
	
	var player_pos = to_local(Global.player.global_position)
	var dot_product = rand_direction.dot(player_pos)
	var interest = clamp(dot_product, 0.5, 1.0)
	
	var distance = position.distance_to(player_pos)
	distance = clamp(distance, min_distance, max_distance)
	target.position = global_position + (rand_direction * interest) * distance
