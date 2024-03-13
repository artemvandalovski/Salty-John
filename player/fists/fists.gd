extends Item

signal drag_started(node: Draggable)
signal drag_stopped(node: Draggable)

@onready var drag_raycast = $DragRayCast as RayCast2D
@onready var right_fist = $Right
@onready var left_fist = $Left


## The current Draggable the player is dragging
## Warning: may be null
var dragging_node: Draggable = null


func _physics_process(delta):
	handle_drag()
	
	# Prioritize dragging over attacking
	if is_dragging():
		# Temporary just to get things going
		# Suggestion: Add a `DragCenter: Marker2D` in between both fists and move it to there instead
		dragging_node.global_position = lerp(
			dragging_node.global_position,
			global_position, 0.1
		)
		return
	
	# Not dragging anything, update fists
	right_fist.update(delta)
	left_fist.update(delta)


func is_dragging() -> bool:
	return dragging_node != null

func handle_drag():
	if Input.is_action_just_pressed("drag"):
		if drag_raycast.is_colliding():
			dragging_node = drag_raycast.get_collider().owner
			drag_started.emit(dragging_node)
		return
	
	# If we're not dragging anymore, let go
	if !Input.is_action_pressed("drag") and dragging_node != null:
		drag_stopped.emit(dragging_node)
		dragging_node = null
	
