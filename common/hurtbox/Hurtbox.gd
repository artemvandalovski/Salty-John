class_name Hurtbox
extends Area2D


signal damaged(dmg)
signal knocked_back(kb)

@export var is_enabled = true

@onready var invincibility_timer = $InvincibilityTimer


func _ready():
	collision_layer = 16
	collision_mask = 0


func damage(dmg: int):
	if !is_enabled or !invincibility_timer.is_stopped(): return
	emit_signal("damaged", dmg)
	invincibility_timer.start()

func knockback(kb: Vector2):
	if !is_enabled: return
	emit_signal("knocked_back", kb)
