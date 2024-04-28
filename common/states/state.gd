class_name State
extends Node

signal transition(new_state_name: StringName)

func _ready():
	set_processes(false)


func enter():
	set_processes(true)
	
func exit():
	set_processes(false)

func set_processes(status: bool):
	set_process(status)
	set_physics_process(status)
