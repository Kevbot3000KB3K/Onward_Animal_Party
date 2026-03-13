extends Node3D

@export var gridmap: GridMap

func _process(_delta):

	var cell = get_mouse_cell()

	if cell != null:

		var world_pos = gridmap.map_to_local(cell)
		position = world_pos

func get_surface_cell(cell: Vector3i) -> Vector3i:

	var highest_cell = cell

	for y in range(cell.y + 1, 20):

		var check_cell = Vector3i(cell.x, y, cell.z)

		if gridmap.get_cell_item(check_cell) == -1:
			break

		highest_cell = check_cell

	return highest_cell

func get_mouse_cell():

	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()

	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_dir = camera.project_ray_normal(mouse_pos)
	var ray_end = ray_origin + ray_dir * 200

	var space = get_world_3d().direct_space_state

	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	query.collide_with_areas = false
	query.collide_with_bodies = true

	# only hit the gridmap
	query.collision_mask = gridmap.collision_layer

	var result = space.intersect_ray(query)

	if result:

		var hit_pos = result.position

		# push the hit upward slightly to avoid wall hits
		hit_pos.y += 0.5

		var cell = gridmap.local_to_map(hit_pos)

		return get_surface_cell(cell)

	return null
