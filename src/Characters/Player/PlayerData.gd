extends Node

signal inventory_updated(inv)

# name -> image
var inventory = {}

func _ready():
	reset()

func reset():
	inventory = {}
	emit_signal("inventory_updated", inventory)

func add_item(name, image) -> void:
	if has_item(name):
		print("HEY! Player already has item: %s" %name)
		return
	inventory[name] = image
	emit_signal("inventory_updated", inventory)

func remove_item(name) -> void:
	if not has_item(name):
		print("HEY! Trying to remove non-existing item from player: %s" %name)
		return
	inventory.erase(name)
	emit_signal("inventory_updated", inventory)

func has_item(name) -> bool:
	return inventory.has(name)
