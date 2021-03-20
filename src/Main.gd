extends Node2D

onready var camera_controller = $CameraController
onready var player = $YSort/Player
onready var npc_container = $YSort/NPCs
onready var ui = $UserInterface

export(PackedScene) var end_scene

func _ready() -> void:
	Courtain.play("show", true)
	AudioController.lerp_music_volume(-60, 0.0)
	AudioController.music.play("carpe_diem")
	AudioController.lerp_music_volume(-24, 12.0)
	camera_controller.set_target_instant(player)
	camera_controller.set_zoom_level("far", false)
	camera_controller.set_zoom_level("medium")
	for npc in npc_container.get_children():
		npc.connect("dialogue_started", ui, "_on_dialogue_started")
	# DEBUG NPCS
	for npc in $_DEBUG/NPCs.get_children():
		npc.connect("dialogue_started", ui, "_on_dialogue_started")
	set_physics_process(false)
	yield(get_tree().create_timer(1.0), "timeout")
	set_physics_process(true)

func _physics_process(delta):
#	if Input.is_action_just_pressed("debug_reset"):
#		restart_scene()
	player.update_fsm()
	
func restart_scene():
	PlayerData.reset()
	SceneController.reload_current()
	# Reset dialogue
	DialogueController._initialize()

func _on_EndSceneTrigger_body_entered(body):
	player.lerp_set_max_speed(3.0, 4.0)
	yield(get_tree().create_timer(2.0), "timeout")
	Courtain.play("show")
	AudioController.sfx.play("wind_big")
	AudioController.lerp_music_volume(-60, 8.0)
	yield(Courtain.anim_player, "animation_finished")
	yield(get_tree().create_timer(2.0), "timeout")
	SceneController.load_scene(end_scene)
	pass
	
