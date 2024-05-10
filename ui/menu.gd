extends Control


func _on_start_pressed():
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://levels/office.tscn")


func _on_quit_pressed():
	get_tree().quit()
