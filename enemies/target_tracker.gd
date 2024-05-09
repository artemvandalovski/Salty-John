class_name TargetTracker
extends RayCast2D

signal breadcrumb_hit

@export var target_radius: float = 10.0
@export var visible_target: bool = false

#@onready var target: Marker2D = $Target
@onready var target = $Target


func _ready():
	if visible_target:
		var sp = Sprite2D.new()
		sp.texture = load("res://icon.svg")
		sp.modulate = Color(2.0, 0.0, 1.0, 1.0)
		sp.set_scale(Vector2(0.2, 0.2))
		target.add_child(sp)


func is_target_on_sight() -> bool:
	set_target_position(target.position)
	if is_colliding():
		print("lost track")
		return false
	#print("tracking")
	return true
