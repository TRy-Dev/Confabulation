extends CanvasLayer

onready var label = $bg/Label

const DECIMAL_PRECISION = 0.001
var stats = []

func _ready():
	$UpdateTimer.start()
	$GameVersion.text = GameSettings.game_version

func clear_stats():
	stats = []

func add_stat(stat_name, object, stat_ref, is_method):
	stats.append([stat_name, object, stat_ref, is_method])

func update_overlay() -> void:
	var label_text = ""
	var fps = Engine.get_frames_per_second()
	label_text += str("FPS: %s\n" %fps)
	var mem = OS.get_static_memory_usage()
	label_text += str("Static Memory: %s\n" % String.humanize_size(mem))
	label_text += "-----\n"
	for s in stats:
		var value = null
		if s[1] and weakref(s[1]).get_ref():
			if s[3]:
				value = s[1].call(s[2])
			else:
				value = s[1].get(s[2])
		if typeof(value) == TYPE_REAL:
			value = stepify(value, DECIMAL_PRECISION)
		elif typeof(value) == TYPE_VECTOR2:
			value.x = stepify(value.x, DECIMAL_PRECISION)
			value.y = stepify(value.y, DECIMAL_PRECISION)
		label_text += str(s[0], ": ", value)
		label_text += "\n"
	label.text = label_text

func _on_UpdateTimer_timeout():
	update_overlay()
