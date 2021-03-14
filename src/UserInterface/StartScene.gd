extends Control


export (PackedScene) var next_scene

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		SceneController.load_scene(next_scene)
