extends Node

const TOP_SCORES_COUNT := 3
const SCORES_AROUND_COUNT := 1

var all_scores = {}

func _ready():
	_configure_silent_wolf()

func _configure_silent_wolf():
	SilentWolf.configure({
		"api_key": "GDU5OZGZmu533EPX0kfRvaT1ZGqJY6gZjzP0d6S3",
		"game_id": "Confabulation",
		"game_version": GameSettings.game_version,
		"log_level": 0
	})

func submit_score(player_name: String, player_score: int) -> void:
	all_scores = {}
	yield(SilentWolf.Scores.get_high_scores(TOP_SCORES_COUNT), "sw_scores_received")
	_add_scores_to_dict(SilentWolf.Scores.scores, all_scores)
	yield(SilentWolf.Scores.get_scores_around(
		player_score, SCORES_AROUND_COUNT), "sw_scores_around_received")
	_add_scores_to_dict(SilentWolf.Scores.scores_above, all_scores)
	var player_position = int(SilentWolf.Scores.position)
	all_scores[player_position] = {
		"index": player_position,
		"player_name": player_name,
		"score": player_score
	}
	_add_scores_to_dict(SilentWolf.Scores.scores_below, all_scores)
	var score_id = yield(SilentWolf.Scores.persist_score(
		player_name, player_score), "sw_score_posted")

func _add_scores_to_dict(scores, dict: Dictionary) -> void:
	for i in range(len(scores)):
		var score = scores[i]
		# Top scores give different API response - no "position"
		var idx = i + 1
		if score.has("position"):
			idx = int(score.position)
		dict[idx] = {
			"index": idx,
			"player_name": score.player_name,
			"score": score.score
		}

#func _wipe_leaderboard():
#	yield(SilentWolf.Scores.wipe_leaderboard(), "sw_leaderboard_wiped")
#	print("Leaderboard wiped")
