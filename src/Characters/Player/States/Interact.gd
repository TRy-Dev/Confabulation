extends State

var interaction = null

func enter(previous: State) -> void:
	owner.velocity = Vector2.ZERO
	owner.update_animation()
	interaction = owner.get_current_interaction()
	interaction.connect("interaction_finished", self, "_on_interaction_finished")

func exit(next: State) -> void:
	interaction.disconnect("interaction_finished", self, "_on_interaction_finished")
	interaction = null

#func update(input: Dictionary) -> void:
#	if Input.is_action_just_pressed("interact"):
#		emit_signal("finished", "Move")

func _on_interaction_finished():
	emit_signal("finished", "Move")
