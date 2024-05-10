extends Node2D
class_name WaveManager

const COWORKER = preload("res://enemies/coworker.tscn")

@export var y_sort: Node

@onready var timer = $Timer

var enemies_amount = 1
var remaining_enemies: int


func _ready():
	assert(y_sort != null, "Please set the y_sort node")
	wave_begin()


func wave_begin():
	for enemy in enemies_amount:
		spawn_enemy()

func wave_completed():
	enemies_amount += 1
	timer.start()

func spawn_enemy():
	var enemy = COWORKER.instantiate()
	enemy.position = Global.tilemap.get_rand_floor_tile()
	enemy.connect("hurt", _on_enemy_hurt)
	enemy.connect("dead", _on_enemy_dead)
	y_sort.add_child(enemy)
	remaining_enemies += 1

func _on_enemy_hurt():
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy: Enemy in enemies:
		enemy.hostile = true

func _on_enemy_dead():
	remaining_enemies -= 1
	if remaining_enemies <= 0:
		wave_completed()


func _on_timer_timeout():
	wave_begin()
