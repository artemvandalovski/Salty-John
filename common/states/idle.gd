class_name Idle
extends State

@onready var context_steering = $"../../ContextSteering"

func _process(delta):
	print("idle")
