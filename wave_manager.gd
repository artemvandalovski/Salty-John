extends Node2D
class_name WaveManager

const COWORKER = preload("res://enemies/coworker.tscn")

var remaining_enemies: int

@onready var y_sort = $"../Y-Sort"


func _ready():
	spawn_enemy()


func spawn_enemy():
	var enemy = COWORKER.instantiate()
	enemy.position = Global.tilemap.get_rand_floor_tile()
	enemy.connect("dead", _on_enemy_dead)
	y_sort.add_child(enemy)
	remaining_enemies += 1


func _on_enemy_dead():
	remaining_enemies -= 1
	
