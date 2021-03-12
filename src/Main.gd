extends Node2D

func _ready() -> void:
	pass
	AudioController.music.play("devious_preparations")
	AudioController.set_bus_volume("Music", -20)
	Courtain.play("show", true)
