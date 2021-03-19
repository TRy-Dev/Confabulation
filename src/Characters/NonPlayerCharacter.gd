extends Character

class_name NonPlayerCharacter

signal dialogue_started(npc)

export(Texture) var texture
export(Texture) var ui_texture

onready var dialogue_interaction :DialogueInteraction = $DialogueInteraction
onready var sprite = $Sprite

func _ready():
	if texture:
		sprite.texture = texture
	else:
		print("HEY! No texture for NPC %s" %name)
	anim_player.playback_speed = 0.5
	AnimationController.play(anim_player, "idle")
	$Control/NameLabel.text = name

func start_dialogue() -> void:
	emit_signal("dialogue_started", self)

func get_dialogue_name() -> String:
	return name.replace(" ", "_").to_lower()

func get_dialogue_interaction() -> DialogueInteraction:
	return dialogue_interaction

func get_image():
	return ui_texture

func get_name() -> String:
	return name

func destroy():
	print("NPC %s destroyed" %name)
	queue_free()
