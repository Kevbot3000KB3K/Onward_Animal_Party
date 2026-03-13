extends Node3D

@export var gridmap: GridMap
@export var grid_controller : Node

func _process(_delta):

	var column = get_mouse_column()

	if column == null:
		return

	if grid_controller.map_data.has(column):

		var data = grid_controller.map_data[column]

		if data.terrain.walkable:

			var cell = Vector3i(column.x, data.height, column.y)

			var world_pos = gridmap.map_to_local(cell)
			world_pos.y += 0.5

			position = world_pos

func get_surface_cell(cell: Vector3i) -> Vector3i:

	for y in range(cell.y + 5, -5, -1):

		var check = Vector3i(cell.x, y, cell.z)

		if gridmap.get_cell_item(check) != -1:
			return check

	return cell

func get_mouse_column():

	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()

	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_dir = camera.project_ray_normal(mouse_pos)

	var space = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_origin + ray_dir * 500)

	var result = space.intersect_ray(query)

	if result:

		var hit = result.position
		var cell = gridmap.local_to_map(hit)

		return Vector2i(cell.x, cell.z)

	return null

func is_cell_walkable(cell: Vector3i) -> bool:

	var item = gridmap.get_cell_item(cell)

	if item == -1:
		return false

	if not grid_controller.terrain_lookup.has(item):
		return false

	var terrain = grid_controller.terrain_lookup[item]

	return terrain.walkable

func get_top_walkable_cell(base_cell: Vector3i) -> Vector3i:

	for y in range(20, -5, -1): # search from top down

		var check = Vector3i(base_cell.x, y, base_cell.z)

		var item = gridmap.get_cell_item(check)

		if item == -1:
			continue

		if grid_controller.terrain_lookup.has(item):

			var terrain = grid_controller.terrain_lookup[item]

			if terrain.walkable:
				return check

	return base_cell
