extends Interaction


func start(player: PlayerAvatar) -> void:
	.start(player)
	owner.play_animation("pick_up")
	yield(player.pickup_item(owner), "completed")
	finish()

func finish() -> void:
	.finish()
	owner.destroy()
