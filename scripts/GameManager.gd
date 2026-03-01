extends Node

signal game_started
signal game_over
signal score_changed(new_score)
signal time_changed(new_time)

var score : int = 0
var is_game_active : bool = false
var time_left : float = 0.0

func start_game(duration : float = 60.0):
	score = 0
	time_left = duration
	is_game_active = true
	emit_signal("game_started")

func end_game():
	is_game_active = false
	emit_signal("game_over")

func add_score(amount : int):
	score += amount
	emit_signal("score_changed", score)

func _process(delta):
	if is_game_active:
		time_left -= delta
		emit_signal("time_changed", time_left)
		if time_left <= 0:
			end_game()
