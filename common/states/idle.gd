class_name Idle
extends State

@export var min_wait_time = 1.0
@export var max_wait_time = 3.0

@export var player_tracker: PlayerTracker

var wait_time: float


func _ready():
	assert(player_tracker != null, "Please set the player_tracker node")

func enter():
	owner.direction = Vector2.ZERO
	wait_time = randf_range(min_wait_time, max_wait_time)

func process(delta):
	wait_time -= delta
	if wait_time <= 0:
		transition.emit("patrol")
	if player_tracker.is_player_on_sight() and owner.hostile:
		transition.emit("chase")
