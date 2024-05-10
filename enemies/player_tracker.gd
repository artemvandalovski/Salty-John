class_name PlayerTracker
extends RayCast2D

signal player_spotted
signal player_lost

@export var target: Marker2D
@onready var sprite_2d = $"../Target/Sprite2D"

func _ready():
	assert(target != null, "Please set the target node")
	sprite_2d.visible = Global.DEBUG
	target.global_position = self.global_position


# TODO add signals
func is_player_on_sight() -> bool:
	if Global.player == null: return false
	set_target_position(to_local(Global.player.position))
	if is_colliding():
		return false
	return true
