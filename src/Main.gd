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
	player.update_fsm()
