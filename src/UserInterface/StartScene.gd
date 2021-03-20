extends Node2D

onready var name_input = $UI/Name/VBoxContainer/LineEdit
onready var anim_player = $AnimationPlayer

export (PackedScene) var next_scene

enum STATES {INIT, NAME, MOVE}

var state = -1

var space_hint_shown = false

func _ready():
	AnimationController.reset(anim_player)
	name_input.grab_focus()
	name_input.clear()
	name_input.release_focus()
	Courtain.play("show", true)
	$CameraController.set_zoom_level("medium", false)
	_init_state(STATES.INIT)

func _physics_process(delta):
	_update_state()
	
#	if Input.is_action_just_pressed("interact"):
#		SceneController.load_scene(next_scene)

func _init_state(st: int):
	match st:
		STATES.INIT:
			AnimationController.play(anim_player, "init")
		STATES.NAME:
			AnimationController.play(anim_player, "name")
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			name_input.grab_focus()
		STATES.MOVE:
			pass
	state = st

func _update_state():
	match state:
		STATES.INIT:
			if Input.is_action_just_pressed("click"):
				_init_state(STATES.NAME)
		STATES.NAME:
			pass
		STATES.MOVE:
			pass

func _on_LineEdit_text_changed(new_text):
	new_text = new_text.strip_escapes()
	new_text = new_text.strip_edges()
	new_text = new_text.replace("!", "")
	if len(new_text) > 0 and not space_hint_shown:
		space_hint_shown = true
		print("Should show space hint")
	name_input.text = new_text
	name_input.caret_position = len(new_text)

func _on_LineEdit_text_entered(new_text):
	pass # Replace with function body.
