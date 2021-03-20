extends Node2D

onready var camera_controller = $CameraController
onready var player = $YSort/Player
onready var npc_container = $YSort/NPCs
onready var ui = $UserInterface

func _ready() -> void:
	Courtain.play("show", true)
	AudioController.lerp_music_volume(-60, 0.0)
	AudioController.music.play("carpe_diem")
	AudioController.lerp_music_volume(-20, 16.0)
	camera_controller.set_target_instant(player)
	camera_controller.set_zoom_level("far", false)
	camera_controller.set_zoom_level("medium")

	for npc in npc_container.get_children():
		npc.connect("dialogue_started", ui, "_on_dialogue_started")
		
	# DEBUG NPCS
	for npc in $_DEBUG/NPCs.get_children():
		npc.connect("dialogue_started", ui, "_on_dialogue_started")

func _physics_process(delta):
	if Input.is_action_just_pressed("debug_reset"):
		restart_scene()
#	if Input.is_action_just_pressed("interact"):
#		AudioController.sfx.play("leaves")
	player.update_fsm()
	
func restart_scene():
	PlayerData.reset()
	SceneController.reload_current()
	# Reset dialogue
	DialogueController._initialize()

func _on_EndSceneTrigger_body_entered(body):
	print("TBI. Start EndScene")
	pass
	
