extends Node2D

const PUNCH_DEPTH = 16.0 # how far the fists will go for a punch
const CHARGE_DEPTH = 8.0 # how far the fists will go back while charging
const COOLDOWN = 0.07
const CHARGE_RATE = 2.0
const MAX_CHARGE = -1
const MIN_KNOCKBACK = 200.0

const L_CLICK = "left_click"
const R_CLICK = "right_click"

@onready var l_fist = $LeftFist
@onready var r_fist = $RightFist
@onready var l_hitbox = $LeftFist/LeftHB
@onready var r_hitbox = $RightFist/RightHB

var l_charge = 0.0
var r_charge = 0.0


func _process(delta):
	handle_charge(delta)
	handle_punch(delta)


func handle_charge(delta):
	if Input.is_action_pressed(L_CLICK):
		l_charge = charge(l_charge, delta)
		l_fist.position.x = l_charge * CHARGE_DEPTH
	
	if Input.is_action_pressed(R_CLICK):
		r_charge = charge(r_charge, delta)
		r_fist.position.x = r_charge * CHARGE_DEPTH

func handle_punch(delta):
	if Input.is_action_just_released(L_CLICK):
		punch(l_fist, l_charge)
		l_charge = 0.0
	if Input.is_action_just_released(R_CLICK):
		punch(r_fist, r_charge)
		r_charge = 0.0

func charge(charge: float, delta):
	return max(charge - CHARGE_RATE * delta, MAX_CHARGE)

func punch(fist: Node2D, charge: float):
	l_hitbox.enabled = true
	var punch_tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	punch_tween.tween_property(fist, 'position:x', charge + PUNCH_DEPTH, 0.1)
	punch_tween.tween_property(fist, 'position:x', 0, COOLDOWN)
	l_hitbox.enabled = false
