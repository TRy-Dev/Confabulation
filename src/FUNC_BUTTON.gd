extends Button

func _on_pressed() -> void:
	if has_method(name):
		call(name)
	else:
		push_error("HEY! UI button trying to call function: %s" % name)

func play_music() -> void:
	AudioController.music.play()

func pause_music() -> void:
	AudioController.music.pause()

func stop_music() -> void:
	AudioController.music.stop()

func play_sfx() -> void:
	AudioController.sfx.play("click")

func play_courtain_flash() -> void:
	Courtain.play("flash")
