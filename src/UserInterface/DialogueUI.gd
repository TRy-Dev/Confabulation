extends PanelContainer

signal dialogue_finished()

onready var npc_image = $HBoxContainer/Npc/ImageContainer/Image
onready var npc_name = $HBoxContainer/Npc/Name
onready var dialogue_text = $HBoxContainer/Dialogue/Text
onready var dialogue_options_container = $HBoxContainer/Dialogue
onready var text_tween = $TextTween

const END_DIALOGUE_TEXT = "Bye!"
const CHARS_PER_SECOND = 45
const MIN_TWEEN_TIME = 0.3

var options_buttons = []
var current_btn_idx = -1

var current_interaction = null
var current_npc :NonPlayerCharacter = null

var destroy_npc_after_dialogue = false

var button_prefab = preload("res://src/UserInterface/OptionButton.tscn")

func _ready():
	_finish_dialogue()

func start_dialogue(npc: NonPlayerCharacter) -> void:
	current_interaction = npc.get_dialogue_interaction()
	current_npc = npc
	npc_image.texture = npc.get_image()
	var nm = npc.get_name()
	if nm == "Death":
		nm = ""
	npc_name.text = nm
	var dialogue = DialogueController.start_dialogue(npc.get_dialogue_name())
	if not dialogue.text:
		print("Hey! Dialogue %s not found. Dialogue dict:" %npc.get_dialogue_name())
		print(dialogue)
		call_deferred("_finish_dialogue")
		return
	_set_dialogue(dialogue)

func _set_dialogue(dialogue: Dictionary) -> void:
	_clear_option_buttons()
	var FLAG_NO_EXIT_STRING = '!FL(noExit)'
	var noExit = false
	var FLAG_DESTROY_NPC_STRING = "!FL(destroy_npc)"
	var text = ""
	for l in dialogue["lines"]:
		if l == "":
			continue
		if l.find(FLAG_NO_EXIT_STRING) != -1:
			l = l.replace(FLAG_NO_EXIT_STRING, "")
			noExit = true
		if l.find(FLAG_DESTROY_NPC_STRING) != -1:
			l = l.replace(FLAG_DESTROY_NPC_STRING, "")
			destroy_npc_after_dialogue = true
		text += l + "\n"
	text = text.rstrip("\n")
	dialogue_text.percent_visible = 0.0
	dialogue_text.text = text
	text_tween.stop_all()
	var tween_time = len(dialogue_text.text) / CHARS_PER_SECOND
	tween_time = max(MIN_TWEEN_TIME, tween_time)
	text_tween.interpolate_property(dialogue_text, "percent_visible", 0.0, 1.0, tween_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	text_tween.start()
	yield(text_tween, "tween_all_completed")
	if not destroy_npc_after_dialogue:
		var first_button = true
		for c in dialogue["choices"]:
			var choice_text = c["text"]
			var choice_index = c["index"]
			_add_button(choice_text, choice_index, first_button)
			first_button = false
	if not noExit:
		_add_button(END_DIALOGUE_TEXT, -1, false)
	current_btn_idx = 0
	options_buttons[current_btn_idx].grab_focus()

func _destroy_current_npc():
	if not current_npc:
		print("HEY! Trying to destroy npc, but no curret npc found!")
		return
	current_npc.destroy()

func _finish_dialogue():
	_clear_option_buttons()
	if current_interaction:
		emit_signal("dialogue_finished")
		current_interaction.finish()
	else:
		print("HEY! Theres no current_interaction when trying to finish dialogue!")
	if destroy_npc_after_dialogue:
		_destroy_current_npc()
	npc_image.texture = null
	npc_name.text = ""
	dialogue_text.text = ""
	current_interaction = null
	current_npc = null
	destroy_npc_after_dialogue = false

func _add_button(text: String, idx: int, is_first: bool) -> void:
	var btn = button_prefab.instance()
	dialogue_options_container.add_child(btn)
	text = text.replace("<br>", "\n")
	btn.get_node("Label").text = text
	btn.is_first = is_first
	btn.connect("pressed", self, "_on_choice_selected", [idx])
	options_buttons.append(btn)

func _clear_option_buttons():
	for b in options_buttons:
		b.queue_free()
	options_buttons = []

func _on_choice_selected(idx) -> void:
	options_buttons[current_btn_idx].release_focus()
	if idx < 0:
		AudioController.sfx.play("ui_proceed")
		_finish_dialogue()
		return
	AudioController.sfx.play("ui_proceed")
	var dialogue = DialogueController.select_option(idx)
	_set_dialogue(dialogue)
