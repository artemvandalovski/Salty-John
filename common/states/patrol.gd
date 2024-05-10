class_name Patrol
extends State

@export var patroling_speed = 20.0
@export var max_distance = 300.0
@export var min_distance = 200.0
@export var target_radius = 30.0

@export var context_steerer: ContextSteerer
@export var player_tracker: PlayerTracker


func _ready():
	assert(context_steerer != null, "Please set the context_steerer node")
	assert(player_tracker != null, "Please set the player_tracker node")


func enter():
	owner.speed = patroling_speed
	set_patrol_point()

func process(delta):
	owner.direction = context_steerer.calc_steering()
	if player_tracker.is_player_on_sight() and owner.hostile:
		transition.emit("chase")
	elif owner.position.distance_to(context_steerer.target_marker.position) < target_radius:
		transition.emit("idle")


func set_patrol_point():
	var patrol_position = Global.tilemap.get_rand_floor_tile()
	var ray: RayCast2D = RayCast2D.new()
	add_child(ray)
	ray.set_collision_mask(1)
	ray.set_target_position(to_local(patrol_position))
	ray.force_raycast_update()
	if ray.is_colliding():
		patrol_position = ray.get_collision_point()
	context_steerer.target_marker.set_position(patrol_position)
	ray.queue_free()
