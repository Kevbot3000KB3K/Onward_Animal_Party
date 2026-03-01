extends CanvasLayer

@onready var score_label = $UIRoot/ScoreLabel
@onready var timer_label = $UIRoot/TimerLabel
@onready var game_over_panel = $UIRoot/GameOverPanel

func _ready():
	print("UI READY")

	GameManager.score_changed.connect(update_score)
	GameManager.game_over.connect(show_game_over)
	GameManager.time_changed.connect(update_timer)

	# Initialize values immediately
	update_score(GameManager.score)
	update_timer(GameManager.time_left)

func update_score(new_score):
	score_label.text = "Score: " + str(new_score)

func update_timer(new_time):
	timer_label.text = "Time: " + str(int(new_time))

func show_game_over():
	game_over_panel.visible = true
