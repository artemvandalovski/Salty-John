class_name PlayerTracker
extends RayCast2D

signal player_spotted
signal player_lost

@export var target_radius: float = 10.0
@export var visible_target: bool = false

@onready var player = Global.player

# TODO add signals
func is_player_on_sight() -> bool:
	set_target_position(to_local(player.position))
	if is_colliding():
		return false
	return true
