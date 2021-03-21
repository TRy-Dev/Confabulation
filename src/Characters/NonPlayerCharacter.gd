extends Character

class_name NonPlayerCharacter

signal dialogue_started(npc)
signal npc_destroyed(npc)

export(Texture) var texture
export(Texture) var ui_texture
export(Color) var ui_color

onready var dialogue_interaction :DialogueInteraction = $DialogueInteraction
onready var sprite = $Sprite
onready var move_up_tween = $MoveUpTween

const MOVE_VECTOR = Vector2(0.0, -25.0)
const MOVE_DURATION = 1.5

func _ready():
	$CollisionShape2D.disabled = false
	if texture:
		sprite.texture = texture
	else:
		print("HEY! No texture for NPC %s" %name)
	anim_player.playback_speed = 0.5
	$Control/NameLabel.text = name
	AnimationController.reset(anim_player)
	yield(get_tree(), "idle_frame")
	AnimationController.play(anim_player, "idle")

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
	dialogue_interaction.call_deferred("disable_interaction")
	$CollisionShape2D.disabled = true
	var start_pos = sprite.global_position
	var end_pos = start_pos + MOVE_VECTOR
	move_up_tween.interpolate_property(sprite, "global_position", start_pos, end_pos, MOVE_DURATION, Tween.TRANS_SINE, Tween.EASE_IN)
	move_up_tween.start()
	AnimationController.play(anim_player, "hide", false)
	yield(move_up_tween, "tween_all_completed")
	print("NPC %s destroyed" %name)
	emit_signal("npc_destroyed", self)
	queue_free()
