extends Node3D

@onready var unit = $Feliz
@onready var ui = $UI
@onready var camera_rig = $CameraRig


func _ready():

	ui.walk_pressed.connect(unit.walk)
	ui.wait_pressed.connect(_on_ui_wait_pressed)

	ui.curate_pressed.connect(unit.set_curate)
	ui.marksman_pressed.connect(unit.set_marksman)
	ui.nude_pressed.connect(unit.set_nude)

	ui.rotate_right_pressed.connect(_rotate_right)
	ui.rotate_left_pressed.connect(_rotate_left)

	ui.zoom_in_pressed.connect(camera_rig.zoom_in)
	ui.zoom_out_pressed.connect(camera_rig.zoom_out)


func _rotate_right():

	camera_rig.rotate_right()
	unit.update_sprite_facing(camera_rig.rotation_index)


func _rotate_left():

	camera_rig.rotate_left()
	unit.update_sprite_facing(camera_rig.rotation_index)


func _on_ui_wait_pressed():

	unit.begin_facing_selection()
