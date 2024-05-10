class_name PlayerTracker
extends RayCast2D

signal player_spotted
signal player_lost


# TODO add signals
func is_player_on_sight() -> bool:
	set_target_position(to_local(Global.player.position))
	if is_colliding():
		return false
	return true
