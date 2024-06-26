extends CharacterBody2D

const FRICTION = 0.8
const SPEED = 100.0

@export var health := 5
@export var mass := 1

@onready var sprite = $Sprite2D
@onready var health_label = $Health
@onready var hurtbox = $Hurtbox
@onready var invincibility_timer = $Hurtbox/InvincibilityTimer


func _ready():
	health_label.visible = Global.DEBUG
	update_label()
	Global.player = self


func _physics_process(delta):
	handle_movement()
	flip_sprite()


func handle_movement():
	var movement_input = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	var acceleration = movement_input * SPEED
	velocity += acceleration
	velocity *= FRICTION
	move_and_slide()

func take_damage(dmg: int):
	health -= dmg
	start_invincibility()
	update_label()
	if health <= 0:
		get_tree().change_scene_to_file("res://ui/menu.tscn")

func take_knockback(kb: Vector2):
	velocity += kb / mass

func start_invincibility():
	hurtbox.set_deferred("monitoring", false)
	invincibility_timer.start()

func flip_sprite():
	sprite.flip_h = get_local_mouse_position().x < 0.0
	
func update_label():
	health_label.text = str(health) + "HP"


func _on_invincibility_timer_timeout():
	hurtbox.monitoring = true


func _on_hurtbox_area_entered(area):
	if area.owner.get_groups()[0] == "Enemies":
		take_damage(1)
		take_knockback(area.owner.velocity + (area.owner.direction * randi_range(300, 600)))
