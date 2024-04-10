extends Node2D

const NUM_RAYS = 8
const RAY_LENGTH = 100

var angle_step = TAU / NUM_RAYS

@onready var player: Node2D = Global.player


func _ready():
	generate_raycasts()


func generate_raycasts():
	for i in range(NUM_RAYS):
		var ray = RayCast2D.new()
		var direction = Vector2(cos(i * angle_step), sin(i * angle_step)) * RAY_LENGTH
		ray.collision_mask = 5
		ray.set_target_position(direction)
		add_child(ray)

func calc_steering() -> Vector2:
	var result = Vector2.ZERO
	var target = to_local(player.global_position)
	for i in range(NUM_RAYS):
		var ray: RayCast2D = get_child(i)
		var direction = ray.target_position.normalized()
		var interest = calc_interest(direction, target)
		var danger = calc_danger(ray) * 5
		result += direction * (interest - danger)
	return result.normalized()

func calc_interest(direction: Vector2, target: Vector2) -> float:
	var dot_product = direction.dot(target)
	return clamp(dot_product, 0.0, 1.0)
	
func calc_danger(ray: RayCast2D) -> float:
	if !ray.is_colliding(): return 0.0
	var collision_distance = ray.get_collision_point().distance_to(global_position)
	return clamp(1.0 - collision_distance / RAY_LENGTH, 0.0, 1.0)
