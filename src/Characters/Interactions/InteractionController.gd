extends Area2D

signal interaction_entered(interaction)
signal interaction_exited(interaction)

var interaction :Interaction = null

func start_interaction(player: PlayerAvatar) -> bool:
	if not interaction:
		print("No interaction to start")
		return false
	interaction.start(player)
	return true

func _on_area_entered(area):
	if interaction:
		print("HEY! Overriding interaction %s with %s" %[interaction.name, area.name])
	interaction = area
	print("Interaction entered: %s" %area.name)
	emit_signal("interaction_entered", interaction)

func _on_area_exited(area):
	print("Interaction exited: %s" %area.name)
	emit_signal("interaction_exited", interaction)
	interaction = null
