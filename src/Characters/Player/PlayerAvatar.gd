extends Character

class_name PlayerAvatar

onready var interaction_controller = $InteractionController
onready var fsm = $StateMachine
onready var sprite = $Sprite

const MOVE_MIN_VELOCITY_SQ = pow(10.0, 2.0)

export(Texture) var idle_tileset
export(Texture) var walk_tileset

var current_frame = 0
const FRAME_COUNT = 4

func _ready():
	fsm.connect("state_changed", $StateNameDisplay, "_on_state_changed")
	fsm.initialize()

func update_fsm():
	fsm.update({})

func interact() -> bool:
	return interaction_controller.start_interaction(self)

func get_current_interaction():
	return interaction_controller.interaction

func pickup_item(item: GroundItem) -> void:
#	print("Player is picking up item %s" %item.name)
	PlayerData.add_item(item.name)
	yield(get_tree().create_timer(0.2), "timeout")
	pass

func update():
	.update()
	if velocity.length_squared() > MOVE_MIN_VELOCITY_SQ:
		# move
		var move_dir = velocity.normalized()
		pass
	else:
		#idle
		pass

func _on_AnimFrameTimer_timeout():
	pass # Replace with function body.

func pixel_perfect():
	pass
		# Pixel perfect position for player - is too jarring
#	var fract_pos = Vector2(Math.fract(global_position.x), Math.fract(global_position.y))
#	if fract_pos.x < 0:
#		if fract_pos.x > -0.5:
#			sprite.position.x = -1 * (1.0 - fract_pos.x)
#		else:
#			sprite.position.x = fract_pos.x
#	else:
#		if fract_pos.x > 0.5:
#			sprite.position.x = 1.0 - fract_pos.x
#		else:
#			sprite.position.x = -1 * fract_pos.x
#	if fract_pos.y < 0:
#		if fract_pos.y > -0.5:
#			sprite.position.y = -1 * (1.0 - fract_pos.y)
#		else:
#			sprite.position.y = fract_pos.y
#	else:
#		if fract_pos.y > 0.5:
#			sprite.position.y = 1.0 - fract_pos.y
#		else:
#			sprite.position.y = -1 * fract_pos.y
