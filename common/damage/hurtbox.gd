class_name Hurtbox
extends Area2D
## Areas that recieve damage from [Hitbox]es


func _ready():
	config()

func config():
	collision_layer = 16 # hurtbox layer
	collision_mask = 8 # hitbox layer


func apply_damage(dmg: int):
	if !owner.has_method("take_damage"):
		return
	owner.take_damage(dmg)


func apply_knockback(knockback: Vector2):
	if !owner.has_method("take_knockback"):
		return
	owner.take_knockback(knockback)
