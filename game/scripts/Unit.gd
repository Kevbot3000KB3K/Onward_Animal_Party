extends Node3D

@onready var body: AnimatedSprite3D = $Body
@onready var gear: AnimatedSprite3D = $Gear
@onready var hair: AnimatedSprite3D = $Hair

var choosing_facing = false
var current_facing = "DL"
const DIRECTIONS = ["UL","UR","DR","DL"]

@export var default_gear_frames : SpriteFrames

var current_direction = "DL"
var current_state = "idle"

@export var curate_frames : SpriteFrames
@export var marksman_frames : SpriteFrames

func _ready():
	if gear.sprite_frames == null:
		gear.sprite_frames = default_gear_frames
	update_animation()

func _process(_delta):

	if choosing_facing:
		update_facing_preview()

func update_facing_preview():

	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()

	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_dir = camera.project_ray_normal(mouse_pos)

	# create a horizontal plane at the player's height
	var plane = Plane(Vector3.UP, global_position.y)

	var hit_pos = plane.intersects_ray(ray_origin, ray_dir)

	if hit_pos != null:
		update_direction(hit_pos)

func update_direction(world_pos):

	var dir = (world_pos - global_position).normalized()

	var camera = get_viewport().get_camera_3d()

	var cam_forward = -camera.global_transform.basis.z
	var cam_right = camera.global_transform.basis.x

	# flatten vectors to ignore vertical tilt
	cam_forward.y = 0
	cam_right.y = 0

	cam_forward = cam_forward.normalized()
	cam_right = cam_right.normalized()

	var forward_dot = dir.dot(cam_forward)
	var right_dot = dir.dot(cam_right)

	if forward_dot > 0 and right_dot > 0:
		set_direction("UR")

	elif forward_dot > 0 and right_dot < 0:
		set_direction("UL")

	elif forward_dot < 0 and right_dot > 0:
		set_direction("DR")

	else:
		set_direction("DL")

func set_direction(dir):

	current_facing = dir
	
	$WaitOrbs/Orb_UL.visible = dir == "UL"
	$WaitOrbs/Orb_UR.visible = dir == "UR"
	$WaitOrbs/Orb_DL.visible = dir == "DL"
	$WaitOrbs/Orb_DR.visible = dir == "DR"
	
	match dir:
		"UL":
			face_up_left()
		"UR":
			face_up_right()
		"DL":
			face_down_left()
		"DR":
			face_down_right()

func update_sprite_facing(camera_rot):

	var index = DIRECTIONS.find(current_facing)

	var visible_index = (index + camera_rot) % 4

	var visible_dir = DIRECTIONS[visible_index]

	match visible_dir:

		"UL":
			face_up_left()

		"UR":
			face_up_right()

		"DL":
			face_down_left()

		"DR":
			face_down_right()

func _input(event):

	if choosing_facing and event.is_action_pressed("click"):
		confirm_facing(get_parent().camera_rig.rotation_index)

func confirm_facing(camera_rot):

	choosing_facing = false
	
	hide_orbs()

	update_sprite_facing(camera_rot)

func hide_orbs():

	$WaitOrbs/Orb_UL.visible = false
	$WaitOrbs/Orb_UR.visible = false
	$WaitOrbs/Orb_DL.visible = false
	$WaitOrbs/Orb_DR.visible = false

func update_animation():

	var anim = current_state + current_direction

	if body.sprite_frames.has_animation(anim):
		body.play(anim)

	if gear.sprite_frames and gear.sprite_frames.has_animation(anim):
		gear.animation = anim

	if hair.sprite_frames and hair.sprite_frames.has_animation(anim):
		hair.animation = anim

	hair.visible = current_direction == "UL"

	gear.frame = body.frame
	hair.frame = body.frame
		
func begin_facing_selection():

	choosing_facing = true
	
	show_orbs()
	
func show_orbs():

	$WaitOrbs/Orb_UL.visible = true
	$WaitOrbs/Orb_UR.visible = true
	$WaitOrbs/Orb_DL.visible = true
	$WaitOrbs/Orb_DR.visible = true
		
func face_up_right():
	current_direction = "UL"
	set_flip(true)
	update_animation()

func face_up_left():
	current_direction = "UL"
	set_flip(false)
	update_animation()

func face_down_right():
	current_direction = "DL"
	set_flip(true)
	update_animation()

func face_down_left():
	current_direction = "DL"
	set_flip(false)
	update_animation()
	
func set_flip(value):

	body.flip_h = value
	gear.flip_h = value
	hair.flip_h = value
	
func walk():
	current_state = "walk"
	update_animation()

func wait():
	current_state = "idle"
	update_animation()
	
func set_curate():
	gear.sprite_frames = curate_frames
	update_animation()

func set_marksman():
	gear.sprite_frames = marksman_frames
	update_animation()

func set_nude():
	gear.visible = false
	
func show_gear():
	gear.visible = true


func _on_up_pressed() -> void:
	face_up_right()


func _on_left_pressed() -> void:
	face_up_left()


func _on_right_pressed() -> void:
	face_down_right()


func _on_down_pressed() -> void:
	face_down_left()


func _on_walk_pressed() -> void:
	walk()


func _on_wait_pressed() -> void:
	wait()


func _on_curate_pressed() -> void:
	set_curate()


func _on_marksman_pressed() -> void:
	set_marksman()


func _on_nude_pressed() -> void:
	set_nude()

func _on_body_frame_changed():

	gear.frame = body.frame

	if hair.visible:
		hair.frame = body.frame
