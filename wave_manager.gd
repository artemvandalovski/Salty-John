extends Node2D
class_name WaveManager

const COWORKER = preload("res://enemies/coworker.tscn")

var enemies_amount = 1
var remaining_enemies: int

@onready var y_sort = $"../Y-Sort"


func _ready():
	spawn_enemy()


func wave_begin():
	for enemy in enemies_amount:
		spawn_enemy()

func wave_completed():
	enemies_amount += 1
	wave_begin()

func spawn_enemy():
	var enemy = COWORKER.instantiate()
	enemy.position = Global.tilemap.get_rand_floor_tile()
	enemy.connect("dead", _on_enemy_dead)
	y_sort.add_child(enemy)
	remaining_enemies += 1


func _on_enemy_dead():
	remaining_enemies -= 1
	if remaining_enemies <= 0:
		wave_completed()
