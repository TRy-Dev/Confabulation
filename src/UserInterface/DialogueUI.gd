extends PanelContainer

onready var npc_image = $HBoxContainer/Npc/Image
onready var npc_name = $HBoxContainer/Npc/Name
onready var dialogue_text = $HBoxContainer/Dialogue/Text
onready var dialogue_options_container = $HBoxContainer/Dialogue

const END_DIALOGUE_TEXT = "Bye!"

var options_buttons = []
var current_btn_idx = -1

var current_interaction = null

func start_dialogue(npc: NonPlayerCharacter) -> void:
	current_interaction = npc.get_dialogue_interaction()
	print("Starting debug dialogue instead of %s" %npc.get_dialogue_name())
	npc_image.texture = npc.get_image()
	npc_name.text = npc.get_name()
	var dialogue = DialogueController.start_dialogue("debug_dialogue")
	_set_dialogue(dialogue)

func _set_dialogue(dialogue: Dictionary) -> void:
	_clear_option_buttons()
	dialogue_text.text = dialogue["text"]
	for i in range(len(dialogue["options"])):
		var opt = dialogue["options"][i]
		_add_button(opt.text, i)
	_add_button(END_DIALOGUE_TEXT, -1)
#	text_tween.stop_all()
#	text_tween.interpolate_property(text, "percent_visible", 0.0, 1.0, len(text.text) / CHARS_PER_SECOND, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#	text_tween.start()
	current_btn_idx = 0
	options_buttons[current_btn_idx].grab_focus()

func _finish_dialogue():
	current_interaction.finish()
	_clear_option_buttons()
	npc_image.texture = null
	npc_name.text = ""
	dialogue_text.text = ""
	current_interaction = null

func _add_button(text: String, idx: int) -> void:
	var btn = Button.new()
	btn.text = text
	btn.connect("pressed", self, "_on_option_selected", [idx])
	dialogue_options_container.add_child(btn)
	options_buttons.append(btn)

func _clear_option_buttons():
	for b in options_buttons:
		b.queue_free()
	options_buttons = []

func _on_option_selected(idx) -> void:
	options_buttons[current_btn_idx].release_focus()
	if idx < 0:
		_finish_dialogue()
		return
	var dialogue = DialogueController.select_option(idx)
	_set_dialogue(dialogue)
