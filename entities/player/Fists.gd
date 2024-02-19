extends Node2D

const PUNCH_DEPTH = 16.0 # how far the fists will go for a punch
const CHARGE_DEPTH = 8.0 # how far the fists will go back while charging
const COOLDOWN = 0.04
const MIN_KNOCKBACK = 200.0

@export var charge_rate: float = 2.0
@export var punch_force: float = 300.0 # how much the player will launch forward when punching
@export var knockback: float = 400.0
@export var dmg: int = 0 # base damage
@export var full_dmg: int = 2 # damage when fully charged

@onready var l_fist = $LFist
@onready var r_fist = $RFist

var lcharge: float = 0.0 # between -1 and 1
var rcharge: float = 0.0 # between -1 and 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed('lclick') and lcharge <= 0.0:
		lcharge = max(lcharge - charge_rate*delta, -1.0)
		$LFist.position.x = lcharge * CHARGE_DEPTH
	
	if Input.is_action_pressed('rclick') and rcharge <= 0.0:
		rcharge = max(rcharge - charge_rate*delta, -1.0)
		$RFist.position.x = rcharge * CHARGE_DEPTH
