extends Node

var ink_runtime = preload("res://addons/inkgd/runtime.gd")
var story_prefab = preload("res://addons/inkgd/runtime/story.gd")
var story

const STORY_PATH = "res://assets/dialogue/dialogue.ink.json"

const DEBUG_OPTION_TEXT = "_p_"

func _ready():
	call_deferred("_initialize")

func start_dialogue(name: String) -> Dictionary:
	story.choose_path_string(name)
	return _get_current_dialogue()

#func extract_text(name: String) -> String:
#	story.choose_path_string(name)
#	var dialogue = _get_current_dialogue()
#	var text = ""
#	for line in dialogue.lines:
#		text += line
#	return text

func select_option(index: int) -> Dictionary:
	story.choose_choice_index(index)
	return _get_current_dialogue()

func set_variable(variable, value) -> void:
	story.variables_state.set(variable, value)

func _initialize():
	ink_runtime.init(get_tree().root)
	_load_story()

func _load_story():
	var ink_story = File.new()
	ink_story.open(STORY_PATH, File.READ)
	var content = ink_story.get_as_text()
	ink_story.close()
	self.story = story_prefab.new(content)

func _get_current_dialogue() -> Dictionary:
	var text_lines = []
	var text = ""
	while story.can_continue:
		var line = story.continue()
#		var tags = story.current_tags
		line = _get_parsed_text(line)
		if line != "":
			text_lines.append(line)
			text += line
	var choices = story.current_choices
	for c in choices:
		if c.text == DEBUG_OPTION_TEXT:
#			print("Debug option text removed")
			choices.erase(c)
			break
	var choices_texts = []
	for c in choices:
		var c_text = c.text
		c_text = _get_parsed_text(c_text)
		if c_text != "":
			choices_texts.append(c_text)
	return {
		"text": text,
		"lines": text_lines,
		"choices": choices_texts
	}

# Parse element for custom function calls 
# and return if should be added to dialogue or if is locked
# Return empty string if should not be added, parsed string if found fn_call and should be added
# or unchanged text if no fn_call found
func _get_parsed_text(text: String) -> String:
	text = text.strip_edges()
	var FUNCTION_IDENTIFIER = "!FN"
	if not text.find(FUNCTION_IDENTIFIER) == 0:
		return text
	text = text.lstrip(FUNCTION_IDENTIFIER)
	var option_text = text.split(")")[1]
	text = text.lstrip("(")
	text = text.rstrip(option_text)
	text = text.rstrip(")")
	option_text = option_text.strip_edges()
	var text_elements = text.split(",")
	var fn = text_elements[0].replace(" ", "")
	var arg = text_elements[1].replace(" ", "")
	match fn:
		"has_item":
			if PlayerData.has_item(arg):
				return _get_parsed_text(option_text)
			else:
				return ""
		"remove_item":
			PlayerData.remove_item(arg)
			return _get_parsed_text(option_text)
		"unlock_a":
			PlayerData.unlock_achievement(arg)
			return _get_parsed_text(option_text)
		"add_item":
			PlayerData.add_item(arg)
			return _get_parsed_text(option_text)
	print("HEY! Text parser could not find matching for options:\nfn: %s\narg: %s" %[fn, arg])
	return ""

#func save_story() -> String:
#	return story.state.to_json()
#
#func load_story(json) -> void:
#	story.state.load_json(json)
