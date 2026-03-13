extends Node

@export var movement_system : Node
@export var grid_controller : Node
@export var selected_unit : Node


func _on_ui_move_pressed():

	print("Move button pressed")

	if selected_unit == null:
		return

	var unit_cell = selected_unit.get_current_cell()

	var column = Vector2i(unit_cell.x, unit_cell.z)

	if !grid_controller.map_data.has(column):
		return

	var data = grid_controller.map_data[column]

	var start_cell = Vector3i(column.x, data.height, column.y)

	var tiles = movement_system.calculate_move_range(
		start_cell,
		selected_unit.move_range
	)

	movement_system.show_move_tiles(tiles)



func _on_ui_wait_pressed():

	if selected_unit == null:
		return

	selected_unit.begin_facing_selection()
