extends Node2D

const FISTS: PackedScene = preload("res://player/fists/fists.tscn")

@export var default_item: PackedScene = FISTS

@onready var hand = $Hand

var current_item: Node2D = null


func _ready():
	set_item(default_item.instantiate())


func _process(delta):
	look_at(get_global_mouse_position())


func set_item(item: Node2D):
	hand.add_child(item)
	item.holder = owner
	current_item = item
