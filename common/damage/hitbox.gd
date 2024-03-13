class_name Hitbox extends Area2D

## Area that can deal damage to [Hurtbox]es
## 
## Usage: [br]
## Call [method deal_damage] to deal damage to all overlapping Hurtboxes[br]
## Set [member knockback_func][code]: func(Hurtbox) -> Vector2[/code] to handle knockback

@export var damage = 1

# [code]func(Hurtbox) -> Vector2[/code]
# Warning: may be null
# E.g.   func(_hurtbox: Hurtbox) -> Vector2:	return Vector2.ZERO
var knockback_func: Callable


func _ready():
	config()

func config():
	collision_layer = 8 # hitbox layer
	collision_mask = 16 # hurtbox layer


## Deals damage and knockback to all overlapping Hurtboxes
## As for knockback, it can be configured by setting [member knockback_func]
func deal_damage():
	var do_apply_kb: bool = knockback_func != null
	
	for hurtbox in get_overlapping_areas():
		assert(hurtbox is Hurtbox)
		
		hurtbox.apply_damage(damage)
		
		if do_apply_kb:
			var kb: Vector2 = knockback_func.call(hurtbox)
			hurtbox.apply_knockback(kb)


## Similar to [method deal_damage] but only deals knockback
func deal_knockback():
	if knockback_func == null:
		push_warning("Attempting to apply knockback but knockback_func is not configured. Ignoring...")
		return
	
	for hurtbox in get_overlapping_areas():
		assert(hurtbox is Hurtbox)
		
		var kb: Vector2 = knockback_func.call(hurtbox)
		hurtbox.apply_knockback(kb)

