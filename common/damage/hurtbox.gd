class_name Hurtbox
extends Area2D


func _ready():
	config()
	connect("area_entered", _on_area_entered)


func config():
	collision_layer = 16
	collision_mask = 8

func _on_area_entered(hitbox: Hitbox):
	if hitbox == null:
		return
	
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
	
	if owner.has_method("take_knockback"):
		if hitbox.owner.has_method("get_knockback"):
			var kb = hitbox.owner.get_knockback()
			owner.take_knockback(kb)
