extends Character

class_name PlayerAvatar

onready var interaction_controller = $InteractionController
onready var fsm = $StateMachine
onready var sprite = $Sprite
onready var anim_tree = $AnimationTree
onready var anim_mode = anim_tree.get("parameters/playback")

const ITEM_PICK_UP_DURATION = 0.2

func _ready():
	_set_anim_dir(Vector2.DOWN)
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
	yield(get_tree().create_timer(ITEM_PICK_UP_DURATION), "timeout")
	pass

func update():
	.update()
	update_animation()

func update_animation():
	if velocity.length_squared() > 1.1:
		var move_dir = velocity.normalized()
		_set_anim_dir(move_dir)
		anim_mode.travel("Walk")
	else:
		if _get_input_direction():
			var move_dir = _get_input_direction().normalized()
			_set_anim_dir(move_dir)
		anim_mode.travel("Idle")

#func set_anim(name):
#	anim_mode.travel(name)

func _get_input_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

func _set_anim_dir(dir: Vector2):
	anim_tree.set('parameters/Idle/blend_position', dir)
	anim_tree.set('parameters/Walk/blend_position', dir)
