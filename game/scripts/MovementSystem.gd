extends Node3D

@export var gridmap: GridMap
@export var grid_controller: Node

var selected_unit

const MOVE_TILE = preload("res://game/scenes/MoveableTileHighlight.tscn")


func calculate_move_range(start_cell: Vector3i, move_points: int):

	var open_list = []
	var reachable = {}

	open_list.append({
		"cell": start_cell,
		"cost": move_points
	})

	while open_list.size() > 0:

		var current = open_list.pop_front()

		var cell = current.cell
		var cost = current.cost

		var key = Vector2i(cell.x, cell.z)

		if reachable.has(key):
			if reachable[key] >= cost:
				continue

		reachable[key] = cost

		for dir in [
			Vector3i(1,0,0),
			Vector3i(-1,0,0),
			Vector3i(0,0,1),
			Vector3i(0,0,-1)
		]:

			var column = Vector2i(cell.x + dir.x, cell.z + dir.z)

			if !grid_controller.map_data.has(column):
				continue

			var data = grid_controller.map_data[column]

			var neighbor = Vector3i(column.x, data.height, column.y)

			var item = gridmap.get_cell_item(neighbor)

			if !grid_controller.terrain_lookup.has(item):
				continue

			var terrain = grid_controller.terrain_lookup[item]

			if !terrain.walkable:
				continue

			var move_cost = terrain.move_cost
			var remaining = cost - move_cost

			if remaining < 0:
				continue

			open_list.append({
				"cell": neighbor,
				"cost": remaining
			})

	return reachable



func show_move_tiles(tiles):

	print("Showing tiles:", tiles.size())

	clear_tiles()

	for key in tiles:

		if !grid_controller.map_data.has(key):
			continue

		var data = grid_controller.map_data[key]

		var cell = Vector3i(key.x, data.height, key.y)

		var world = gridmap.map_to_local(cell)

		var tile = MOVE_TILE.instantiate()
		tile.name = "MoveTile"

		add_child(tile)

		tile.global_position = world
		tile.global_position.y += gridmap.cell_size.y * 0.5 + 0.02

		tile.cell = cell
		tile.tile_selected.connect(_on_tile_selected)



func clear_tiles():

	for child in get_children():

		if child.name == "MoveTile":
			child.queue_free()



func _on_tile_selected(cell):

	print("Player chose tile:", cell)
