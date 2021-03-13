extends PhysicalObject2D

class_name Character

export(float, 0.0, 100.0) var move_speed = 100.0

func move(dir: Vector2) -> void:
	if dir:
		dir = dir.normalized()
		apply_force(dir * move_speed)
	update()
