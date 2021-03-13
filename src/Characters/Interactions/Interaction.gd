extends Area2D

class_name Interaction

signal interaction_started()
signal interaction_finished()

func start() -> void:
	print("Iteraction %s started" %name)
	emit_signal("interaction_started")
	yield(get_tree().create_timer(1.0), "timeout")
	finish()

func finish() -> void:
	print("Iteraction %s finished" %name)
	emit_signal("interaction_finished")
