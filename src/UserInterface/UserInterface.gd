extends CanvasLayer

onready var dialogue_ui = $Screen/DialogueUI
onready var anim_player = $AnimationPlayer
onready var achi_anim_player = $AchievementsAnimPlayer

var achievements_visible = false

const ACHI_VISIBLE_DURATION = 6.0

func _ready():
	$Screen/AchievementsUI.show_text()
	AnimationController.reset(anim_player)
	PlayerData.connect("achievements_updated", self, "_on_achievements_updated")
	dialogue_ui.connect("dialogue_finished", self, "_on_dialogue_finished")

func _on_dialogue_started(npc: NonPlayerCharacter) -> void:
	AnimationController.play(anim_player, "show")
	yield(anim_player, "animation_finished")
#	yield(get_tree().create_timer(ANIM_DELAY), "timeout")
	dialogue_ui.start_dialogue(npc)

func _on_dialogue_finished():
	AnimationController.play(anim_player, "show", false, true)

func _on_achievements_updated(achievements, count, unlocked_achi) -> void:
	if count < 1:
		return
	if achievements_visible:
		return
	achievements_visible = true
	AnimationController.play(achi_anim_player, "show")
	yield(get_tree().create_timer(ACHI_VISIBLE_DURATION), "timeout")
	AnimationController.play(achi_anim_player, "show", false, true)
	achievements_visible = false
