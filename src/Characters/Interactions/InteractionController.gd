extends Area2D

signal interaction_entered(interaction)
signal interaction_exited(interaction)

onready var interaction_ui = $InteractionUI

var interaction :Interaction = null

func _ready():
	connect("interaction_entered", interaction_ui, "_on_interaction_entered")
	connect("interaction_exited", interaction_ui, "_on_interaction_exited")

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
#	print("Interaction entered: %s" %area.name)
	emit_signal("interaction_entered", interaction)

func _on_area_exited(area):
#	print("Interaction exited: %s" %area.name)
	emit_signal("interaction_exited", interaction)
	interaction = null
