extends Weapon

const PUNCH_DEPTH = 16 # how far the fists will go for a punch
const CHARGE_DEPTH = 16 # how far the fists will go back while charging
const CHARGE_RATE = 2
const MAX_CHARGE = 2
const COOLDOWN = 0.07

const KNOCKBACK_STRENGTH: float = 200.0
const KNOCKBACK_MIN: float = 100.0

@export_enum("left_click", "right_click") var input: String

@onready var hitbox = $Hitbox

var charge = 0.0

func _ready():
	hitbox.knockback_func = calc_knockback

# Gets called from parent (See Fists)
# The reason for this is to give us more control over when and how these
#  children fists get updated
# E.g. We don't want them to handle attacking while we're dragging a chair
func update(delta: float):
	handle_charge(delta)
	handle_punch()


func handle_charge(delta):
	if Input.is_action_pressed(input):
		charge = minf(charge + CHARGE_RATE * delta, MAX_CHARGE)
		position.x = -CHARGE_DEPTH * (charge / MAX_CHARGE)

func handle_punch():
	if Input.is_action_just_released(input):
		punch()

func punch():
	# Animateji
	var punch_tween: Tween = create_tween()\
		.set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	punch_tween.tween_property(self, 'position:x', charge + PUNCH_DEPTH, 0.1)
	punch_tween.tween_callback(hitbox.deal_damage) # <-- DAMAGE IS DEALT HERE
	punch_tween.tween_property(self, 'position:x', 0, COOLDOWN)
	
	await punch_tween.finished
	
	charge = 0.0

func calc_knockback(_hurtbox: Hurtbox) -> Vector2:
	var velocity = owner.holder.velocity
	var direction = Vector2.from_angle(global_rotation)
	var knockback = velocity + (direction * max(KNOCKBACK_STRENGTH * charge, KNOCKBACK_MIN))
	return knockback
