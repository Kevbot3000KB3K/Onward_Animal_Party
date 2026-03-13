extends Node

@export var movement_system: Node
@export var selected_unit: Node

func _on_move_pressed():

	if selected_unit == null:
		return

	var unit_cell = selected_unit.get_current_cell()

	var tiles = movement_system.calculate_move_range(
		unit_cell,
		selected_unit.move_range
	)

	movement_system.show_move_tiles(tiles)

func _on_wait_pressed():

	if selected_unit == null:
		return

	selected_unit.begin_facing_selection()


func _on_ui_move_pressed() -> void:
	pass # Replace with function body.


func _on_ui_wait_pressed() -> void:
	pass # Replace with function body.
