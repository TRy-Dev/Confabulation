extends Node2D

onready var achievements = $CanvasLayer/UI/AchievementsUI
onready var player = $YSort/Player
onready var anim_player = $AnimationPlayer

const ACHI_DELAY = 8.0
const ACHI_TEXT_DURATION = 5.0
const ACHI_NO_TEXT_DURATION = 1.0


func _ready():
	AnimationController.reset(anim_player)
	Courtain.play("show", true)
	AudioController.lerp_music_volume(-60, 0.0)
	AudioController.music.play("at_rest")
	AudioController.lerp_music_volume(-20, 8.0)
	yield(get_tree(), "idle_frame")
	yield(get_tree().create_timer(ACHI_DELAY), "timeout")
	show_achievements()
#	var submit_name = PlayerData.player_name + "!" + _get_achievement_string()
#	yield(LeaderboardAPI.submit_score(submit_name, PlayerData.achievements_unlocked), "completed")
#	show_leaderboard()

func _physics_process(delta):
	player.update_fsm()

func show_achievements():
	AnimationController.play(anim_player, "achievements", false)
	yield(anim_player, "animation_finished")
	yield(get_tree().create_timer(0.5), "timeout")
	loop_achievements_text()

func show_leaderboard():
	AnimationController.play(anim_player, "leaderboard", false)
	LeaderboardAPI.all_scores

func loop_achievements_text():
	var achievements_unlocked = PlayerData.get_unlocked_achievements()
	while true:
		for achi in achievements_unlocked:
			achievements._set_text(achi["text"])
			achievements.play_anim("show", false)
			yield(achievements.anim_player, "animation_finished")
			yield(get_tree().create_timer(ACHI_TEXT_DURATION), "timeout")
			achievements.play_anim("show", true)
			yield(achievements.anim_player, "animation_finished")
			yield(get_tree().create_timer(ACHI_NO_TEXT_DURATION), "timeout")

func _get_achievement_string() -> String:
	var s = ""
	for achi in PlayerData.achievements.keys():
		var achi_data = PlayerData.achievements[achi]
		if achi_data["unlocked"]:
			s += "1"
		else:
			s += "0"
	return s
