extends Node2D

func _ready():
	print("TitleScreen READY")

func _process(delta):
	if InputManager.start_pressed():
		print("Starting game...")
		GameManager.start_game()
		SceneLoader.load_scene("res://scenes/Game.tscn")
