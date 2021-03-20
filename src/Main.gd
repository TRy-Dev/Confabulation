extends Node2D

onready var camera_controller = $CameraController
onready var player = $YSort/Player
onready var npc_container = $YSort/NPCs
onready var ui = $UserInterface

export(PackedScene) var end_scene

const START_MOVE_DELAY = 0.5

var npcs_destroyed_count = 0

const BASE_MUSIC_VOLUME = -20

func _ready() -> void:
	Courtain.play("show", true)
	AudioController.lerp_music_volume(-60, 0.0)
	AudioController.music.play("carpe_diem")
	AudioController.lerp_music_volume(BASE_MUSIC_VOLUME, 6.0)
	camera_controller.set_target_instant(player)
	camera_controller.set_zoom_level("far", false)
	camera_controller.set_zoom_level("medium")
	for npc in npc_container.get_children():
		npc.connect("dialogue_started", ui, "_on_dialogue_started")
		npc.connect("npc_destroyed", self, "_on_npc_destroyed")
	set_physics_process(false)
	yield(get_tree(), "idle_frame")
	DialogueController.set_story_variable("npc_count", len(npc_container.get_children()))
	yield(get_tree().create_timer(START_MOVE_DELAY), "timeout")
	set_physics_process(true)

func _physics_process(delta):
	player.update_fsm()
#	if Input.is_action_just_pressed("interact"):
#		_on_npc_destroyed(null)
	
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

func _on_npc_destroyed(npc):
	npcs_destroyed_count += 1
	print("Destroyed %s NPCs" %npcs_destroyed_count)
	if npcs_destroyed_count == 7:
		PlayerData.unlock_achievement("farewell")
		_change_music("heartbreaking")
	elif npcs_destroyed_count == 5:
		_change_music("fresh_air")
	elif npcs_destroyed_count == 3:
		_change_music("almost_new")
	yield(get_tree().create_timer(0.3), "timeout")
	DialogueController.set_story_variable("npc_count", len(npc_container.get_children()))

func _change_music(name: String, duration := 4.0) -> void:
	print("Changing music to %s" %name)
	AudioController.lerp_music_volume(-60, duration)
	yield(get_tree().create_timer(duration), "timeout")
	AudioController.music.play(name)
	AudioController.lerp_music_volume(BASE_MUSIC_VOLUME, duration)
