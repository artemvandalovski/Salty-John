class_name ContextSteerer
extends Node2D

@export var target_node: Node2D
@export_group("Rays")
@export var num_rays: int = 8
@export var ray_length: float = 100.0

var player_spotted = false

func _ready():
	generate_raycasts()
	
	if target_node == null:
		target_node = Global.player


func generate_raycasts():
	var angle_step: float = TAU / num_rays
	
	for i in num_rays:
		var ray = RayCast2D.new()
		
		var direction = Vector2.from_angle(i * angle_step) * ray_length
		
		ray.collision_mask = 5
		ray.set_target_position(direction)
		add_child(ray)

func calc_steering() -> Vector2:
	var result = Vector2.ZERO
	var target_pos = to_local(target_node.global_position)
	
	for i in num_rays:
		var ray: RayCast2D = get_child(i)
		var direction = ray.target_position.normalized()
		var interest = calc_interest(direction, target_pos)
		var danger = calc_danger(ray) * 5
		result += direction * (interest - danger)
	return result.normalized()

func calc_interest(direction: Vector2, target: Vector2) -> float:
	var dot_product = direction.dot(target)
	return clamp(dot_product, 0.0, 1.0)
	
func calc_danger(ray: RayCast2D) -> float:
	if !ray.is_colliding(): return 0.0
	var collision_distance = ray.get_collision_point().distance_to(global_position)
	return clamp(1.0 - collision_distance / ray_length, 0.0, 1.0)
