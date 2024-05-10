class_name Enemy
extends CharacterBody2D

const FRICTION = 0.85

signal hurt
signal dead

@export var damage = 1
@export var health := 20
@export var mass := 1
@export var hostile = false

@onready var health_label = $Health

var direction: Vector2
var speed: float = 40.0

func _ready():
	health_label.visible = Global.DEBUG
	update_label()

func _physics_process(delta):
	velocity += direction * speed
	velocity *= FRICTION
	move_and_slide()


func calc_damage(_hurtbox: Hurtbox):
	return damage

func calc_knockback(_hurtbox: Hurtbox) -> Vector2:
	var knockback = velocity + (direction * randi_range(100, 300))
	return knockback

func take_damage(dmg: int):
	health -= dmg
	hostile = true
	emit_signal("hurt")
	update_label()
	if health <= 0:
		emit_signal("dead")
		queue_free()

func take_knockback(kb: Vector2):
	velocity += kb / mass

func update_label():
	health_label.text = str(health) + "HP"
