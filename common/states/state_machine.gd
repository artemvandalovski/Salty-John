class_name StateMachine
extends Node

@export var initial_state: State

var current_state: State

func _ready():
	pass
	#current_state = initial_state

func switch_states(state: State):
	current_state.set_process(false)
	set_process(true)
	current_state = state
