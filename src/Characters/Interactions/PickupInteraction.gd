extends Interaction


func start(player: PlayerAvatar) -> void:
	.start(player)
	owner.play_animation("pick_up")
	AudioController.sfx.play("pop")
	yield(player.pickup_item(owner), "completed")
	finish()

func finish() -> void:
	.finish()
	owner.destroy()
