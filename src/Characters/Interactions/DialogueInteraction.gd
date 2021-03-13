extends Interaction

class_name DialogueInteraction

func start(player: PlayerAvatar) -> void:
	.start(player)
	owner.start_dialogue()

func finish() -> void:
	.finish()
