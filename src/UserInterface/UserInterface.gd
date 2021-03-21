extends CanvasLayer

onready var dialogue_ui = $Screen/DialogueUI
onready var anim_player = $AnimationPlayer
onready var achi_anim_player = $AchievementsAnimPlayer
onready var vignette = $Screen/Vignette
onready var vignette_tween = $VignetteTween

var achievements_visible = false

const ACHI_VISIBLE_DURATION = 6.0

const VIGNETTE_START_INTENSITY = 0.1
const VIGNETTE_END_INTENSITY = 1.5
const VIGNETTE_INTERPOLATION_DURATION = 6.0

func _ready():
	vignette.material.set_shader_param("vignette_intensity", VIGNETTE_START_INTENSITY)
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

func _on_npc_destroyed(count):
	var start_val = vignette.material.get_shader_param("vignette_intensity")
	var val = Math.map(count, 0, 7, VIGNETTE_START_INTENSITY, VIGNETTE_END_INTENSITY)
	print("Set vignette intensity to: %s" %val)
	vignette_tween.stop_all()
	vignette_tween.interpolate_method(self, "interpolate_vignette", start_val, val, VIGNETTE_INTERPOLATION_DURATION, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	vignette_tween.start()

func interpolate_vignette(val):
	vignette.material.set_shader_param("vignette_intensity", val)
