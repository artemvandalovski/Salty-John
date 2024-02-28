class_name Weapon
extends Node2D

@export var breakable = false
@export var pickable = false
@export var durability = 1

@onready var pickup_area = $PickupArea

var holder
