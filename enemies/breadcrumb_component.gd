class_name BreadcrumbComponent
extends RayCast2D

signal breadcrumb_hit

@export var context_steerer: ContextSteerer
@export var target_radius: float = 10.0

var marker: Marker2D


func _enter_tree():
	assert(context_steerer != null, "Please set the context steering node")
	
	collision_mask = 0b1 # Only collide with the world
	marker = Marker2D.new()
	add_child(marker)
	
	marker.top_level = true
	
	context_steerer.target_node = marker
	
	var sp = Sprite2D.new()
	sp.texture = load("res://icon.svg")
	sp.scale *= 0.2
	sp.modulate = Color(2.0, 0.0, 1.0, 1.0)
	marker.add_child(sp)


func _physics_process(_delta: float):
	var player_pos: Vector2 = Global.player.global_position
	update_marker(player_pos)


func update_marker(target_pos: Vector2):
	const WIGGLE_AMOUNT: float = 8.0
	target_pos.x += randf_range(-1.0, 1.0) * WIGGLE_AMOUNT
	target_pos.y += randf_range(-1.0, 1.0) * WIGGLE_AMOUNT
	
	target_position = target_pos - global_position
	
	if is_colliding():
		if owner.global_position.distance_to(marker.global_position) < target_radius:
			breadcrumb_hit.emit()
		return
	
	marker.position = target_pos

