extends State

var interaction = null

func enter(previous: State) -> void:
	owner.velocity = Vector2.ZERO
	owner.look_at_interaction()
	owner.update_animation()
	interaction = owner.get_current_interaction()
	interaction.connect("interaction_finished", self, "_on_interaction_finished")


func _on_interaction_finished():
	interaction.disconnect("interaction_finished", self, "_on_interaction_finished")
	interaction = null
	yield(get_tree().create_timer(0.3), "timeout")
	emit_signal("finished", "Move")
