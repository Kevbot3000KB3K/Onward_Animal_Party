extends Area3D

var cell : Vector3i

signal tile_selected(cell)

func _input_event(camera, event, hit_pos, normal, shape_idx):

	if event.is_action_pressed("click"):
		tile_selected.emit(cell)
