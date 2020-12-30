extends PhysicalObject2D

export(Vector2) var push_force = Vector2(0.0, -1000.0)
export(float, 0.0, 1000.0) var gravity = 100.0
export(float, 0.0, 100.0) var wind = 0.0
export(float, 0.0, 100.0) var x_acceleration = 30.0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		apply_force(push_force)
	var x_move = Input.get_action_strength("right") - Input.get_action_strength("left")
	apply_force(Vector2(x_acceleration * x_move, 0.0))
	apply_force(Vector2(0.0, gravity))
	apply_force(Vector2(wind, 0.0))
	update()
