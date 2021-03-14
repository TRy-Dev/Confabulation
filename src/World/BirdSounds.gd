extends Node2D

onready var audio = $AudioStreamPlayer2D
onready var debug_control = $DebugControl
onready var max_dist = $CollisionShape2D.shape.radius

func _ready():
#	debug_control.visible = false
	audio.max_distance = max_dist
	audio.play()
