extends Character

class_name PlayerAvatar

onready var interaction_controller = $InteractionController
onready var fsm = $StateMachine

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
	print("Player is picking up item %s" %item.name)
	PlayerData.add_item(item.name, item.image)
	yield(get_tree().create_timer(0.2), "timeout")
	pass
