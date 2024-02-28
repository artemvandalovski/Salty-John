extends Node2D

const FISTS: PackedScene = preload("res://player/fists/Fists.tscn")

@export var default_weapon: PackedScene = FISTS

@onready var hand = $Hand

var current_weapon: Node2D = null


func _ready():
	set_weapon(default_weapon.instantiate())


func _process(delta):
	look_at(get_global_mouse_position())


func set_weapon(weapon: Weapon):
	hand.add_child(weapon)
	weapon.holder = owner
	current_weapon = weapon
