extends Camera2D

onready var tween_zoom = $ZoomTween
onready var tween_rotate = $RotateTween

const TRANS_TYPE = Tween.TRANS_SINE
const EASE_TYPE = Tween.EASE_IN_OUT

const ZOOM_DURATION = 2.0

const ROTATION_MIN = -180
const ROTATION_MAX = 180
const ROTATION_DURATION = 2.0

const SHAKE_DECAY = 0.8
const SHAKE_MAX_OFFSET = Vector2(100, 75)
const SHAKE_MAX_ROLL = 0.1
const SHAKE_TRAUMA_POWER = 3
var shake_trauma = 0.0

var noise_y = 0

var _target = null

# string -> float
var _zoom_levels = {
#	"close": 0.2,
	"medium": 0.12,
	"far": 0.2,
}

func _ready():
	randomize()

func _process(delta: float) -> void:
	if _target:
		global_position = _target.global_position
	if shake_trauma:
		shake_trauma = max(shake_trauma - SHAKE_DECAY * delta, 0)
		shake()

func set_target(target):
	_target = target

func set_target_instant(target):
	set_target(target)
	if _target:
		global_position = _target.global_position
	reset_smoothing()

func set_zoom_level(name: String, smoothed := true):
	if not _zoom_levels.get(name):
		print("HEY! Zoom level not found: %s" %name)
		return
	set_zoom(_zoom_levels[name], smoothed)

func set_zoom(val, smoothed := true):
	tween_zoom.stop_all()
	if smoothed:
		tween_zoom.interpolate_property(self, "zoom", zoom, Vector2.ONE * val, ZOOM_DURATION, TRANS_TYPE, EASE_TYPE)
		tween_zoom.start()
	else:
		zoom = Vector2.ONE * val

func set_rotation(val: float, smoothed := true):
	val = clamp(val, ROTATION_MIN, ROTATION_MAX)
	val = deg2rad(val)
	tween_rotate.stop_all()
	if smoothed:
		tween_rotate.interpolate_property(self, "rotation", rotation, val, ROTATION_DURATION, TRANS_TYPE, EASE_TYPE)
		tween_rotate.start()
	else:
		rotation = val

func add_trauma(amount):
	shake_trauma = clamp(shake_trauma + amount, 0.0, 1.0)

func shake():
	var amount = pow(shake_trauma, SHAKE_TRAUMA_POWER)
	noise_y += 1
	rotation = SHAKE_MAX_ROLL * amount * Rng.noise(0, noise_y)
	offset.x = SHAKE_MAX_OFFSET.x * amount * Rng.noise(-17777, noise_y)
	offset.y = SHAKE_MAX_OFFSET.y * amount * Rng.noise(177777, noise_y)
