class_name Chase
extends State

@export var target_radius: float = 50.0

@export var context_steerer: ContextSteerer
@export var player_tracker: PlayerTracker


func _ready():
	assert(context_steerer != null, "Please set the context_steerer node")

func process(delta):
	owner.direction = context_steerer.calc_steering()
	update_chase_position()


func update_chase_position():
	var target = context_steerer.target_marker ## last position seen by the player
	if player_tracker.is_player_on_sight():
		target.set_position(Global.player.position)
	elif owner.position.distance_to(target.position) < target_radius:
		transition.emit("idle")
