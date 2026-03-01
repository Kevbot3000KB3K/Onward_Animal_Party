extends CharacterBody2D

@export var speed : float = 200.0

@export var move_sfx : AudioStream
@export var action_1_sfx : AudioStream
@export var action_2_sfx : AudioStream
@export var action_3_sfx : AudioStream
@export var action_4_sfx : AudioStream

var is_moving := false
var move_player : AudioStreamPlayer

func _ready():
	move_player = AudioStreamPlayer.new()
	add_child(move_player)
	move_player.stream = move_sfx
	move_player.autoplay = false
	move_player.loop = true

func _physics_process(delta):

	var direction := Vector2.ZERO

	if InputManager.move_up():
		direction.y -= 1
	if InputManager.move_down():
		direction.y += 1
	if InputManager.move_left():
		direction.x -= 1
	if InputManager.move_right():
		direction.x += 1

	if direction != Vector2.ZERO:
		direction = direction.normalized()

	velocity = direction * speed
	move_and_slide()

	global_position = global_position.round()

	handle_movement_audio(direction)
	handle_action_sfx()


func handle_movement_audio(direction: Vector2):

	if direction != Vector2.ZERO:
		if not is_moving and move_sfx != null:
			move_player.play()
			is_moving = true
	else:
		if is_moving:
			move_player.stop()
			is_moving = false


func handle_action_sfx():

	if InputManager.action_1_pressed() and action_1_sfx != null:
		AudioManager.play_sfx(action_1_sfx)

	if InputManager.action_2_pressed() and action_2_sfx != null:
		AudioManager.play_sfx(action_2_sfx)

	if InputManager.action_3_pressed() and action_3_sfx != null:
		AudioManager.play_sfx(action_3_sfx)

	if InputManager.action_4_pressed() and action_4_sfx != null:
		AudioManager.play_sfx(action_4_sfx)
