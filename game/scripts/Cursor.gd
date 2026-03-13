extends Node3D

@export var gridmap: GridMap
@export var grid_controller: Node
var last_valid_column : Vector2i = Vector2i.ZERO

func _process(_delta):

	var column = get_mouse_column()

	if column != null:
		last_valid_column = column
	else:
		column = last_valid_column

	if !grid_controller.map_data.has(column):
		return

	var data = grid_controller.map_data[column]

	if data.height < 4:
		return

	if !data.terrain.walkable:
		return

	var cell = Vector3i(column.x, data.height, column.y)

	var world_pos = gridmap.map_to_local(cell)

	world_pos.y += gridmap.cell_size.y * 0.5
	world_pos.y += 0.05

	position = world_pos


func get_mouse_column():

	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()

	if camera == null:
		return null

	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_dir = camera.project_ray_normal(mouse_pos)

	var space = get_world_3d().direct_space_state

	var query = PhysicsRayQueryParameters3D.create(
		ray_origin,
		ray_origin + ray_dir * 500
	)

	query.collide_with_areas = false
	query.collide_with_bodies = true

	var result = space.intersect_ray(query)

	if result:

		var hit = result.position
		var cell = gridmap.local_to_map(hit)

		return Vector2i(cell.x, cell.z)

	return null
