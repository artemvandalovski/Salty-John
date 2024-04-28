class_name Patrol
extends State

@export var max_distance: float = 300.0
@export var min_distance: float = 200.0

var marker: Marker2D

func enter():
	marker = Marker2D.new()
	add_child(marker)
	marker.top_level = true
	
	# Visible
	var sp = Sprite2D.new()
	sp.texture = load("res://icon.svg")
	sp.scale *= 0.2
	sp.modulate = Color(1.0, 0.0, 1.0, 1.0)
	marker.add_child(sp)
	
	update_marker_position()

func process(delta):
	owner.direction = global_position.direction_to(marker.global_position)

## Random but also influenced by the player position
func update_marker_position():
	var rand_radian = randf_range(0, TAU)
	var rand_direction = Vector2.from_angle(rand_radian)
	
	var target = to_local(owner.target.global_position)
	var dot_product = rand_direction.dot(target)
	var interest = clamp(dot_product, 0.5, 1.0)
	
	var distance = position.distance_to(target)
	distance = clamp(distance, min_distance, max_distance)
	marker.global_position = global_position + (rand_direction * interest) * distance
