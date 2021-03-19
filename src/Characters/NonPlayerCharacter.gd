extends Character

class_name NonPlayerCharacter

signal dialogue_started(npc)

onready var dialogue_interaction :DialogueInteraction = $DialogueInteraction
onready var sprite = $Sprite

func _ready():
	$Control/NameLabel.text = name

func start_dialogue() -> void:
	emit_signal("dialogue_started", self)

func get_dialogue_name() -> String:
	return name.replace(" ", "_").to_lower()

func get_dialogue_interaction() -> DialogueInteraction:
	return dialogue_interaction

func get_image():
	return sprite.texture

func get_name() -> String:
	return "NPC name placeholder"

func destroy():
	queue_free()
