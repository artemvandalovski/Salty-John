class_name Hurtbox
extends Area2D


func _ready():
	config()
	connect("area_entered", _on_area_entered)


func config():
	collision_layer = 5
	collision_mask = 4

func _on_area_entered(hitbox: Hitbox):
	if hitbox == null:
		return
	
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
