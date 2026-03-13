extends Node3D

@onready var camera = $CameraPivot/Camera3D
@export var target : Node3D

var rotations = [45,135,225,315]
var current_rotation = 0

var zoom_levels = [12.0, 9.0, 6.5, 4.5, 2.5]
var current_zoom = 2
var rotating = false
var midpoint_angle = 0.0
var midpoint_triggered = false


var rotation_index = 0
	
func _process(delta):

	if target:
		global_position = global_position.lerp(target.global_position, 10 * delta)

	if rotating and not midpoint_triggered:

		var current_angle = rad_to_deg(rotation.y)

		if abs(current_angle - midpoint_angle) < 2:

			midpoint_triggered = true
			target.update_sprite_facing(rotation_index)
		
func rotate_right():

	rotation_index = (rotation_index + 1) % 4

	var start_angle = rad_to_deg(rotation.y)
	var target_angle = start_angle + 90

	midpoint_angle = start_angle + 45
	midpoint_triggered = false
	rotating = true

	var tween = create_tween()

	tween.tween_property(
		self,
		"rotation:y",
		deg_to_rad(target_angle),
		0.35
	)

	tween.finished.connect(_rotation_finished)

func rotate_left():

	rotation_index = (rotation_index - 1 + 4) % 4

	var start_angle = rad_to_deg(rotation.y)
	var target_angle = start_angle - 90

	midpoint_angle = start_angle - 45
	midpoint_triggered = false
	rotating = true

	var tween = create_tween()

	tween.tween_property(
		self,
		"rotation:y",
		deg_to_rad(target_angle),
		0.35
	)

	tween.finished.connect(_rotation_finished)

func _rotation_finished():

	rotating = false

func apply_rotation():

	var target_rot = deg_to_rad(rotations[current_rotation])

	var tween = create_tween()

	tween.tween_property(
		self,
		"rotation:y",
		target_rot,
		0.35
	).set_trans(Tween.TRANS_SINE)

func zoom_in():

	if current_zoom < zoom_levels.size() - 1:
		current_zoom += 1
		apply_zoom()


func zoom_out():

	if current_zoom > 0:
		current_zoom -= 1
		apply_zoom()


func apply_zoom():

	var tween = create_tween()

	tween.tween_property(
		camera,
		"size",
		zoom_levels[current_zoom],
		0.25
	)
