class_name Idle
extends State

@export var min_wait_time: float = 1.0
@export var max_wait_time: float = 3.0

var wait_time: float

func enter():
	print(is_processing())
	wait_time = 1.0 #randf_range(min_wait_time, max_wait_time)

func process(delta):
	wait_time -= delta
	print(wait_time)
	if wait_time <= 0:
		transition.emit("patrol")
