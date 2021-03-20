extends Node2D

onready var name_input = $UI/Name/VBoxContainer/LineEdit
onready var anim_player = $AnimationPlayer
onready var player = $YSort/Player

export (PackedScene) var next_scene

enum STATES {INIT, NAME, MOVE, TRANS_TO_MAIN}

var state = -1

var space_hint_shown = false

onready var move_button_grid = $UI/Move/GridContainer
onready var move_dirs = {
	"left": {
		"pressed": false,
		"anim_player": move_button_grid.get_node("Left/AnimationPlayer")
	},
	"right": {
		"pressed": false,
		"anim_player": move_button_grid.get_node("Right/AnimationPlayer")
	},
	"up": {
		"pressed": false,
		"anim_player": move_button_grid.get_node("Up/AnimationPlayer")
	},
	"down": {
		"pressed": false,
		"anim_player": move_button_grid.get_node("Down/AnimationPlayer")
	},
}

func _ready():
	AudioController.lerp_music_volume(-60, 0.0)
	AudioController.music.play("immersed")
	AudioController.lerp_music_volume(-20, 6.0)
	AnimationController.reset(anim_player)
	for dir in move_dirs.values():
		var anim_p = dir["anim_player"]
		AnimationController.reset(anim_p)
	name_input.grab_focus()
	name_input.clear()
	name_input.release_focus()
	Courtain.play("show", true)
	$CameraController.set_zoom_level("medium", false)
	call_deferred("_init_state", STATES.INIT)

func _physics_process(delta):
	_update_state()
#	if Input.is_action_just_pressed("interact"):
#		SceneController.load_scene(next_scene)

func _init_state(st: int):
	if state == st:
		print("HEY! Trying to set the same state: %s" %st)
		return
	match st:
		STATES.INIT:
			AnimationController.play(anim_player, "init", false)
		STATES.NAME:
			AudioController.sfx.play("ui_proceed")
			AnimationController.play(anim_player, "name", false)
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			name_input.grab_focus()
		STATES.MOVE:
			AudioController.sfx.play("ui_proceed")
			AnimationController.play(anim_player, "move", false)
			name_input.release_focus()
		STATES.TRANS_TO_MAIN:
			state = st
			AudioController.lerp_music_volume(-50, 6.0)
			yield(get_tree().create_timer(2.0), "timeout")
			AudioController.sfx.play("wind_small")
			Courtain.play("show")
			yield(Courtain.anim_player, "animation_finished")
			SceneController.load_scene(next_scene)
	state = st

func _update_state():
	match state:
		STATES.INIT:
			if Input.is_action_just_pressed("click"):
				_init_state(STATES.NAME)
		STATES.NAME:
			if Input.is_action_just_pressed("interact"):
				if len(name_input.text) > 0:
					PlayerData.set_player_name(name_input.text.capitalize())
					_init_state(STATES.MOVE)
		STATES.MOVE:
			for dir in move_dirs.keys():
				var pressed = move_dirs[dir]["pressed"]
				if Input.is_action_just_pressed(dir) and not pressed:
					var anim_p = move_dirs[dir]["anim_player"]
					AnimationController.play(anim_p, "hide")
					move_dirs[dir]["pressed"] = true
					AudioController.sfx.play("start_move_button_pressed_%s" %move_buttons_pressed_count())
			if are_all_move_buttons_pressed():
				_init_state(STATES.TRANS_TO_MAIN)
			player.update_fsm()
		STATES.TRANS_TO_MAIN:
			player.update_fsm()

func move_buttons_pressed_count() -> int:
	var count = 0
	for dir in move_dirs.values():
		if dir["pressed"]:
			count += 1
	return count

func are_all_move_buttons_pressed() -> bool:
	for dir in move_dirs.values():
		if not dir["pressed"]:
			return false
	return true

func _get_input_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

func _on_LineEdit_text_changed(new_text):
	new_text = new_text.strip_escapes()
	new_text = new_text.strip_edges()
	new_text = new_text.replace("!", "")
	if len(new_text) > 0 and not space_hint_shown:
		space_hint_shown = true
		AnimationController.play(anim_player, "show_name_hint", false)
	name_input.text = new_text
	name_input.caret_position = len(new_text)

func _on_LineEdit_text_entered(new_text):
	pass # Replace with function body.

