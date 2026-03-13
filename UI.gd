extends Control

signal walk_pressed
signal wait_pressed
signal curate_pressed
signal marksman_pressed
signal nude_pressed

signal rotate_left_pressed
signal rotate_right_pressed
signal zoom_in_pressed
signal zoom_out_pressed

func _on_walk_pressed():
	walk_pressed.emit()

func _on_wait_pressed():
	wait_pressed.emit()

func _on_curate_pressed():
	curate_pressed.emit()

func _on_marksman_pressed():
	marksman_pressed.emit()

func _on_nude_pressed():
	nude_pressed.emit()

func _on_zoom_in_pressed():
	zoom_in_pressed.emit()

func _on_zoom_out_pressed():
	zoom_out_pressed.emit()


func _on_rotate_right_pressed() -> void:
	rotate_right_pressed.emit()


func _on_rotate_left_pressed() -> void:
	rotate_left_pressed.emit()


func _on_game_scene_ready() -> void:
	pass # Replace with function body.
