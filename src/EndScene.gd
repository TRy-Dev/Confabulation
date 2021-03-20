extends Node2D

onready var achievements_container = $UI/Achievements
onready var player = $YSort/Player
onready var anim_player = $AnimationPlayer

func _ready():
	Courtain.play("show", true)
	AudioController.lerp_music_volume(-60, 0.0)
	AudioController.music.play("at_rest")
	AudioController.lerp_music_volume(-20, 8.0)
	show_achievements()
	var submit_name = PlayerData.player_name + "!" + _get_achievement_string()
	yield(LeaderboardAPI.submit_score(submit_name, PlayerData.achievements_unlocked), "completed")
	show_leaderboard()

func _physics_process(delta):
	player.update_fsm()

func show_achievements():
	AnimationController.play(anim_player, "achievements", false)
	for achi in PlayerData.achievements:
		achievements_container

func show_leaderboard():
	AnimationController.play(anim_player, "leaderboard", false)
	LeaderboardAPI.all_scores

func _get_achievement_string() -> String:
	var s = ""
	for achi in PlayerData.achievements.keys():
		var achi_data = PlayerData.achievements[achi]
		if achi_data["unlocked"]:
			s += "1"
		else:
			s += "0"
	return s
