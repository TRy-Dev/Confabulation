extends State

func update(input: Dictionary) -> void:
	if Input.is_action_just_pressed("interact") and owner.interact():
		emit_signal("finished", "Interact")
		return
	var dir = _get_input_direction()
	owner.move(dir)

func _get_input_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
