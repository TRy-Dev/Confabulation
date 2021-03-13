extends Character

class_name NonPlayerCharacter

signal dialogue_started(npc)

onready var dialogue_interaction :DialogueInteraction = $DialogueInteraction
onready var sprite = $Sprite

func start_dialogue() -> void:
	emit_signal("dialogue_started", self)

func get_dialogue_name() -> String:
	return name

func get_dialogue_interaction() -> DialogueInteraction:
	return dialogue_interaction

func get_image():
	return sprite.texture
