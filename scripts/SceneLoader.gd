extends Node

func load_scene(path : String):
	call_deferred("_deferred_load", path)

func _deferred_load(path : String):
	get_tree().change_scene_to_file(path)
