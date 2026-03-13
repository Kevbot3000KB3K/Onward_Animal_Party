extends Control

signal move_pressed
signal wait_pressed
signal action_pressed
signal inspect_pressed

signal rotate_left_pressed
signal rotate_right_pressed
signal zoom_in_pressed
signal zoom_out_pressed

func _on_move_pressed():
	move_pressed.emit()

func _on_action_pressed():
	action_pressed.emit()
	
func _on_inspect_pressed():
	inspect_pressed.emit()

func _on_wait_pressed():
	wait_pressed.emit()

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
