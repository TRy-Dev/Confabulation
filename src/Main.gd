extends Node2D

onready var camera_controller = $CameraController
onready var player = $Player

func _ready() -> void:
	pass
#	AudioController.music.play("devious_preparations")
#	AudioController.set_bus_volume("Music", -20)
#	Courtain.play("show", true)
	camera_controller.set_target_instant(player)


func _physics_process(delta):
	var dir = _get_input_direction()
	player.move(dir)

func _get_input_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
