class_name Enemy
extends CharacterBody2D

@export var health := 3


func _ready():
	pass


func _process(delta):
	pass


func take_damage(dmg: int):
	print("Damage ", dmg)