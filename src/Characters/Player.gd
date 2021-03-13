extends Character

onready var interaction_controller = $InteractionController
onready var fsm = $StateMachine

func _ready():
	fsm.connect("state_changed", $StateNameDisplay, "_on_state_changed")
	fsm.initialize()

func update_fsm():
	fsm.update({})

func interact() -> bool:
	return interaction_controller.start_interaction()

func get_current_interaction():
	return interaction_controller.interaction
