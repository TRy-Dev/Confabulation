extends Node2D

onready var camera_controller = $CameraController
onready var player = $Player
onready var npc_container = $NPCs
onready var ui = $UserInterface

func _ready() -> void:
	pass
#	AudioController.music.play("devious_preparations")
#	AudioController.set_bus_volume("Music", -20)
#	Courtain.play("show", true)
	camera_controller.set_target_instant(player)
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	for npc in npc_container.get_children():
		npc.connect("dialogue_started", ui, "_on_dialogue_started")

func _physics_process(delta):
	if Input.is_action_just_pressed("debug_reset"):
		SceneController.reload_current()
	player.update_fsm()
