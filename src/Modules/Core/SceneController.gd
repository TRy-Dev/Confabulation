extends Node

signal scene_started_loading(scene)
signal scene_finished_loading(scene)

func load_scene(scene):
	if not scene:
		print("HEY! Trying to load empty scene: %s" %scene)
		return
	emit_signal("scene_started_loading", scene)
	get_tree().change_scene_to(scene)
	emit_signal("scene_finished_loading", scene)

func load_scene_by_path(path):
	var scene = load(path)
	if not scene:
		print("HEY! Scene not found in path%s" %path)
		return
	emit_signal("scene_started_loading", scene)
	get_tree().change_scene_to(scene)
	emit_signal("scene_finished_loading", scene)

func reload_current():
	emit_signal("scene_started_loading", get_tree().get_current_scene())
	get_tree().reload_current_scene()
	emit_signal("scene_finished_loading", get_tree().get_current_scene())
