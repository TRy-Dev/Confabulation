extends Area2D

class_name Interaction

signal interaction_started()
signal interaction_finished()

func _ready():
	$CollisionShape2D.disabled = false

func start(player: PlayerAvatar) -> void:
#	print("Iteraction %s started" %name)
	emit_signal("interaction_started")

func finish() -> void:
#	print("Iteraction %s finished" %name)
	emit_signal("interaction_finished")

func disable_interaction():
	$CollisionShape2D.disabled = true
