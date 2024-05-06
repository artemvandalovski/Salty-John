class_name Chase
extends State

var movement_func: Callable

@onready var context_steerer = $"../../ContextSteerer"

func enter():
	owner.target = Global.player

func process(delta):
	owner.direction = context_steerer.calc_steering()
