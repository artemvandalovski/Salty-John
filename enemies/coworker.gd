class_name Coworker
extends Enemy

@onready var hitbox = $Hitbox
@onready var hurtbox = $Hurtbox


func _ready():
	hitbox.knockback_func = calc_knockback
	hitbox.damage_func = calc_damage
	health_label.visible = Global.DEBUG
	update_label()


func _on_hitbox_area_entered(entered_hurtbox: Hurtbox):
	assert(hurtbox is Hurtbox)
	if entered_hurtbox == hurtbox: return
	hitbox.deal_damage()
