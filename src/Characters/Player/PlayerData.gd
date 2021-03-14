extends Node

signal inventory_updated(inv)
signal achievements_updated(ach)

# name -> image
var inventory = {}

var achievements = {
	"oregano": {
		"text": "Give oregano to mom",
		"image": preload("res://assets/art/debug/rect_16.png"),
		"unlocked": false
	}
}

func _ready():
	reset()

func reset():
	inventory = {}
	emit_signal("inventory_updated", inventory)
	for achi in achievements.values():
		achi["unlocked"] = false
	emit_signal("achievements_updated", achievements)

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

func unlock_achievement(name) -> void:
	name = name.to_lower()
	if not achievements.has(name):
		print("HEY! Trying to unlock non existing achievement: %s" %name)
		return
	achievements[name]["unlocked"] = true
	emit_signal("achievements_updated", achievements)
