extends Node

# Speedrun Module that can be easily hacked by changing system time

var start_time := -1
var stop_time := -1

var paused_time := -1
var paused_duration := 0

func _init():
	reset()

func reset() -> void:
	start_time = -1
	stop_time = -1
	paused_time = -1
	paused_duration = 0

func start() -> void:
	start_time = _get_time()

func stop() -> void:
	stop_time = _get_time()

func get_current_time() -> int:
	if stop_time < 0:
		return _get_time() - start_time - paused_duration
	return stop_time - start_time - paused_duration

func pause() -> void:
	if paused_time >= 0:
		print("Speedrun timer is already paused!")
		return
	paused_time = _get_time()

func unpause() -> void:
	if paused_time < 0:
		print("Speedrun timer is not paused!")
		return
	paused_duration += _get_time() - paused_time
	paused_time = -1

func _get_time() -> int:
	return OS.get_system_time_secs()
