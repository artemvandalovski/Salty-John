class_name StateMachine
extends Node

@export var initial_state = Idle

@onready var current_state = initial_state

func switch_states(state: State):
	current_state = state
