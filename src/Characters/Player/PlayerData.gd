extends Node

signal inventory_updated(inv)
signal achievements_updated(ach)

# name -> image
var inventory = {}

var DEBUG_IMAGE = preload("res://assets/art/debug/rect_16.png")

var achievements = {
	"oregano": {
		"text": "Help make the best spaghetti ever",
		"image": DEBUG_IMAGE,
#		achi["unlocked"] = false
	},
	"good_heart": {
		"text": "Share food with someone in need",
		"image": DEBUG_IMAGE,
	}
}

# name -> image
var item_texture_map = {
#	"Apple": preload("path to apple image")
}

func _ready():
	reset()

func reset():
	inventory = {}
	emit_signal("inventory_updated", inventory)
	for achi in achievements.values():
		achi["unlocked"] = false
	emit_signal("achievements_updated", achievements)

func add_item(name) -> void:
	if has_item(name):
		print("HEY! Player already has item: %s" %name)
		return
	inventory[name] = get_item_texture_by_name(name)
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
	AudioController.sfx.play("success")
	achievements[name]["unlocked"] = true
	emit_signal("achievements_updated", achievements)

func get_item_texture_by_name(name):
	if item_texture_map.has(name):
		return item_texture_map[name]
	print("HEY! Item texture: `%s` not found" %name)
	return DEBUG_IMAGE
