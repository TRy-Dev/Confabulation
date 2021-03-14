extends CanvasLayer

onready var container = $Container

func _ready():
	_show(false)

func _on_interaction_entered(interaction) -> void:
	_show(true)

func _on_interaction_exited(interaction) -> void:
	_show(false)

func _show(val: bool) -> void:
	container.visible = val
