extends Node

@export var movement_system : Node
@export var grid_controller : Node
@export var selected_unit : Node
@export var cursor : Node3D

var is_moving = false


func _ready():
	movement_system.move_tile_chosen.connect(_on_move_tile_chosen)


func _on_move_tile_chosen(cell):

	selected_unit.snap_to_cell(cell, movement_system.gridmap)

	movement_system.clear_tiles()

	cursor.visible = false

	is_moving = false


func _on_ui_move_pressed():

	if is_moving:
		return

	is_moving = true

	var unit_cell = selected_unit.get_current_cell()

	var tiles = movement_system.calculate_move_range(
		unit_cell,
		selected_unit.move_range
	)

	movement_system.show_move_tiles(tiles)

	cursor.visible = true


func _on_ui_wait_pressed():

	if selected_unit == null:
		return

	selected_unit.begin_facing_selection()
