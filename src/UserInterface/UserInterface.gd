extends CanvasLayer

onready var dialogue_ui = $Screen/DialogueUI
onready var anim_player = $AnimationPlayer


const ANIM_DELAY = 0.5

func _ready():
	AnimationController.reset(anim_player)
	dialogue_ui.connect("dialogue_finished", self, "_on_dialogue_finished")

func _on_dialogue_started(npc: NonPlayerCharacter) -> void:
	AnimationController.play(anim_player, "show")
	yield(anim_player, "animation_finished")
	yield(get_tree().create_timer(ANIM_DELAY), "timeout")
	dialogue_ui.start_dialogue(npc)

func _on_dialogue_finished():
	AnimationController.play(anim_player, "show", false, true)
