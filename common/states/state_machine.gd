class_name StateMachine
extends Node

@export var initial_state: State

@onready var state_label = $"../State"

var current_state: State
var states: Dictionary = {}


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transition.connect(switch_states)
		else:
			push_warning("State machine contains child which is not 'State'")
	current_state = initial_state
	current_state.enter()
	state_label.visible = Global.DEBUG
	state_label.text = current_state.name

func _process(delta):
	current_state.process(delta)
		
func _physics_process(delta):
	current_state.physics_process(delta)
	

func switch_states(new_state_name: StringName):
	var new_state = states.get(new_state_name.to_lower())
	if new_state != null:
		if new_state != current_state:
			current_state.exit()
			new_state.enter()
			current_state = new_state
			state_label.text = current_state.name
	else:
		push_warning("Called transition on a state that does not exist")
