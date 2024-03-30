extends Node2D

const NUM_RAYS = 8
const RAY_LENGTH = 100

var angle_step = TAU / NUM_RAYS

@onready var player: Node2D = Global.player


func _ready():
	generate_raycasts()

func _process(delta):
	calc_interest()

func _draw():
	for i in range(NUM_RAYS):
		var ray: RayCast2D = get_child(i)
		var direction: Vector2 = ray.target_position
		
		var forward_direction = to_local(player.global_position)
		var dot_product = direction.dot(forward_direction)
		var importance = clamp(dot_product, 0.0, 1.0)
		print(importance)
		var interest = direction * importance
		
		draw_line(Vector2(), interest, Color.GREEN, 1.0)


func generate_raycasts():
	for i in range(NUM_RAYS):
		var ray = RayCast2D.new()
		var direction = Vector2(cos(i * angle_step), sin(i * angle_step)) * RAY_LENGTH
		ray.collision_mask = 2
		ray.add_exception(owner)
		ray.set_target_position(direction)
		add_child(ray)

func calc_interest():
	var forward_direction = to_local(player.global_position)
