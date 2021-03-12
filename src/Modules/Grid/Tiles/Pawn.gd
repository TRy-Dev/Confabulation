extends Tile

class_name Pawn

export(String) var dialogue_path = ""

func move_to(grid_pos: Vector2) -> void:
	grid_position = grid_pos
	var target_position = grid_pos
	print("How to get global_position from grid_position?")
#	$Tween.stop_all()
#	$Tween.interpolate_property(self, "global_position", 
#			global_position, target_position, GlobalConstants.MOVE_TIME, 
#			Tween.TRANS_SINE, Tween.EASE_IN_OUT)
#	$Tween.start()

func get_name() -> String:
	var s_ref = get_script()
	var path = s_ref.resource_path.split("/")
	var name = path[len(path) - 1].split(".")[0]
	return name.to_lower()

func destroy() -> void:
	if destroyed:
		return
	ParticleController.play("blood", global_position)
	.destroy()
