extends Node

signal scene_started_loading(scene)
signal scene_finished_loading(scene)

const SCENE_LOAD_DELAY = 2.0

func load_scene(scene):
	if scene:
		emit_signal("scene_started_loading", scene)
		yield(get_tree().create_timer(SCENE_LOAD_DELAY), "timeout")
		get_tree().change_scene_to(scene)
		emit_signal("scene_finished_loading", scene)
