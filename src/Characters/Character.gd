extends PhysicalObject2D

class_name Character

export(float, 0.0, 100.0) var move_speed = 100.0

onready var anim_player = $AnimationPlayer

func move(dir: Vector2) -> void:
	if dir:
		dir = dir.normalized()
		apply_force(dir * move_speed)
	update()

func play_animation(name) -> void:
	AnimationController.play(anim_player, name)
