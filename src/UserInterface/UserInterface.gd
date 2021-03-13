extends CanvasLayer

onready var dialogue_ui = $Screen/DialogueUI

func _on_dialogue_started(npc: NonPlayerCharacter) -> void:
	dialogue_ui.start_dialogue(npc)
#	print("start dialogue %s" %dialogue_name)
#	yield(get_tree().create_timer(1.0), "timeout")
#	interaction.finish()
