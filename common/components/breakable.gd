class_name Breakable
extends Node2D

@export var durability = 1

signal break_weapon


func take_damage(dmg: int):
	durability -= dmg
	
	if durability <= 0:
		break_weapon.emit()
