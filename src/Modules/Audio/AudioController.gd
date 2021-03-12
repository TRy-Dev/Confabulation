extends Node

onready var music = $MusicController
onready var sfx = $SfxController

func set_bus_volume(name :String , volume :int) -> void:
	var bus_idx = AudioServer.get_bus_index(name)
	if bus_idx > -1:
		volume = clamp(volume, -80, 0)
		AudioServer.set_bus_volume_db(bus_idx, volume)
	else:
		push_error("HEY! Bus %s does not exist." % name)

func lerp_music_volume(volume :int, duration := 2.0) -> void:
	# https://github.com/godotengine/godot/issues/32882
	# https://www.reddit.com/r/godot/comments/fpmwjx/tweening_audio_bus_volume/
	
	# Hardcoded solution for Music bus
	if duration <= 0.0:
		music._audio_player.volume_db = volume
	else:
		var temp_tween := Tween.new()
		add_child(temp_tween)
		var current_volume_db = music._audio_player.volume_db
		temp_tween.interpolate_property(music._audio_player, "volume_db", current_volume_db, volume, duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		temp_tween.start()
		yield(temp_tween, "tween_all_completed")
		temp_tween.queue_free()
