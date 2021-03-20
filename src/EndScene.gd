extends Node2D

func _ready():
	Courtain.play("show", true)
	AudioController.lerp_music_volume(-60, 0.0)
	AudioController.music.play("at_rest")
	AudioController.lerp_music_volume(-20, 8.0)
