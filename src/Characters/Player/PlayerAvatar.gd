extends Character

class_name PlayerAvatar

onready var interaction_controller = $InteractionController
onready var fsm = $StateMachine
onready var sprite = $Sprite
onready var anim_tree = $AnimationTree
onready var anim_mode = anim_tree.get("parameters/playback")

const ITEM_PICK_UP_DURATION = 0.2

const MOVE_MIN_VELOCITY_SQ = pow(2.0, 2.0)

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
	yield(get_tree().create_timer(ITEM_PICK_UP_DURATION), "timeout")
	pass

func update():
	.update()
	if velocity.length_squared() > MOVE_MIN_VELOCITY_SQ:
		# move
		var move_dir = velocity.normalized()
		anim_tree.set('parameters/Idle/blend_position', move_dir)
		anim_tree.set('parameters/Walk/blend_position', move_dir)
		anim_mode.travel("Walk")
	else:
		#idle
		anim_mode.travel("Idle")

