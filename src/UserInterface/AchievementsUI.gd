extends PanelContainer

onready var container = $VBoxContainer/Container
onready var text_label = $VBoxContainer/Text
onready var anim_player = $AnimationPlayer

var achi_ui_prefab = preload("res://src/UserInterface/AchievementUI.tscn")
var locked_achi_ui_prefab  = preload("res://src/UserInterface/LockedAchievementUI.tscn")

func _ready():
	reset()
	PlayerData.connect("achievements_updated", self, "_on_achievements_updated")
	_on_achievements_updated(PlayerData.achievements, PlayerData.achievements_unlocked, null)

func _on_achievements_updated(achievements, count, unlocked_achi) -> void:
	reset()
	yield(get_tree(), "idle_frame")
	for achi in achievements.values():
		if achi["unlocked"]:
			add_achi(achi_ui_prefab, achi)
		else:
			add_achi(locked_achi_ui_prefab, {})
	if unlocked_achi:
		_set_text(unlocked_achi["text"])
	else:
		_set_text("")

func reset() -> void:
	for c in container.get_children():
		c.queue_free()

func add_achi(prefab, achi):
	var new_achi_ui = prefab.instance()
	container.add_child(new_achi_ui)
	if len(achi) > 0:
		new_achi_ui.initialize(achi)

func _set_text(text: String) -> void:
	text_label.text = text

func play_anim(name, backwards) -> void:
	AnimationController.play(anim_player, name, false, backwards)

func show_text():
	text_label.percent_visible = 1.0
