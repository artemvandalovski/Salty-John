class_name Chase
extends State

@export var target_radius = 10.0
@export var chasing_speed = 40.0

@export var context_steerer: ContextSteerer
@export var player_tracker: PlayerTracker


func _ready():
	assert(context_steerer != null, "Please set the context_steerer node")
	assert(player_tracker != null, "Please set the player_tracker node")


func enter():
	owner.speed = chasing_speed

func process(delta):
	owner.direction = context_steerer.calc_steering()
	follow_player()


func follow_player():
	if Global.player == null: return false
	var target = context_steerer.target_marker ## last position seen by the player
	if player_tracker.is_player_on_sight():
		target.set_position(Global.player.position)
	elif owner.position.distance_to(target.position) < target_radius:
		transition.emit("idle")
