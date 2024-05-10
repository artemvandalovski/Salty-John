class_name Coworker
extends Enemy

@onready var hitbox = $Hitbox
@onready var hurtbox = $Hurtbox


func _ready():
	hitbox.knockback_func = calc_knockback
	hitbox.damage_func = calc_damage
	update_label()


func _on_hitbox_area_entered(hurtbox: Hurtbox):
	assert(hurtbox is Hurtbox)
	if hurtbox == self.hurtbox: return
	hitbox.deal_damage()
