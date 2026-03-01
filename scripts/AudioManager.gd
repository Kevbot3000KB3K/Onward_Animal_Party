extends Node

var music_player : AudioStreamPlayer
var sfx_player : AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)

func play_music(stream):
	music_player.stream = stream
	music_player.play()

func play_sfx(stream):
	var player = AudioStreamPlayer.new()
	player.stream = stream
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)
