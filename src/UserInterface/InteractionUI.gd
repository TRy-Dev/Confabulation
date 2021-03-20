extends CanvasLayer

onready var container = $Container
onready var anim_player = $AnimationPlayer

func _ready():
	AnimationController.reset(anim_player)
#	_show(false)

func interaction_started(interaction: Interaction) -> void:
	if anim_player.current_animation == "show":
		yield(anim_player, "animation_finished")
	_show(false)
	if interaction is DialogueInteraction:
		yield(interaction, "interaction_finished")
		_show(true)

func _on_interaction_entered(interaction) -> void:
	_show(true)

func _on_interaction_exited(interaction) -> void:
	_show(false)

func _show(val: bool) -> void:
	if val:
		AnimationController.play(anim_player, "show")
	else:
		AnimationController.play(anim_player, "show", false, true)
#	container.visible = val
