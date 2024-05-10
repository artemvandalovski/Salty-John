class_name Coworker
extends Enemy

@onready var hurtbox = $Hurtbox


func _ready():
	health_label.visible = Global.DEBUG
	update_label()
