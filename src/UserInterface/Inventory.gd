extends Control

onready var grid = $Inventory/GridContainer
onready var anim_player = $AnimationPlayer

var item_ui_prefab = preload("res://src/UserInterface/ItemUI.tscn")

func _ready():
	PlayerData.connect("inventory_updated", self, "_on_player_inventory_updated")
	AnimationController.reset(anim_player)

func _on_player_inventory_updated(inventory: Dictionary) -> void:
	for c in grid.get_children():
		c.queue_free()
	for item_name in inventory.keys():
		var img = inventory[item_name]
		var new_item = item_ui_prefab.instance()
		grid.add_child(new_item)
		new_item.initialize(item_name, img)
	AnimationController.play(anim_player, "show")
	yield(anim_player, "animation_finished")
	yield(get_tree().create_timer(2.0), "timeout")
	AnimationController.play(anim_player, "show", false, true)
