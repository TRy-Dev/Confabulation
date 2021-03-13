extends PanelContainer

onready var grid = $GridContainer

var item_ui_prefab = preload("res://src/UserInterface/ItemUI.tscn")

func _ready():
	PlayerData.connect("inventory_updated", self, "_on_player_inventory_updated")

func _on_player_inventory_updated(inventory: Dictionary) -> void:
	for c in grid.get_children():
		c.queue_free()
	for item_name in inventory.keys():
		var img = inventory[item_name]
		var new_item = item_ui_prefab.instance()
		grid.add_child(new_item)
		new_item.initialize(item_name, img)
