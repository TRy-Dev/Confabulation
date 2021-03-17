extends PanelContainer

onready var container = $Container

var achi_ui_prefab = preload("res://src/UserInterface/AchievementUI.tscn")

func _ready():
	reset()
	PlayerData.connect("achievements_updated", self, "_on_achievements_updated")

func _on_achievements_updated(achievements) -> void:
	for achi in achievements.values():
		if achi["unlocked"]:
			var new_achi_ui = achi_ui_prefab.instance()
			container.add_child(new_achi_ui)
			new_achi_ui.initialize(achi)

func reset() -> void:
	for c in container.get_children():
		c.queue_free()
