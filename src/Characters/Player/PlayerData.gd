extends Node

signal inventory_updated(inv)
signal achievements_updated(ach, count)

# name -> image
var inventory = {}

var DEBUG_IMAGE = preload("res://assets/art/debug/rect_16.png")

# name -> image
var item_texture_map = {
	"oregano": preload("res://assets/art/ola/items/oregano.png"),
#	"Apple": preload("path to apple image")
}

var achievements = {
	"oregano": {
		"text": "Help make the best spaghetti ever",
		"image": get_item_texture_by_name("oregano"),
#		"unlocked" = false,
	},
	"good_heart": {
		"text": "Share food with someone in need",
		"image": DEBUG_IMAGE,
	},
	"two_apples": {
		"text": "2 apples a day...",
		"image": DEBUG_IMAGE
	},
	"quiz_won": {
		"text": "Complete dinosaur knowledge quiz",
		"image": DEBUG_IMAGE
	},
	"patient": {
		"text": "Be patient",
		"image": DEBUG_IMAGE
	},
	"pussy": {
		"text": "Bring Pussy home",
		"image": DEBUG_IMAGE
	},
	"dog_bone": {
		"text": "Give bone to Benjamin",
		"image": DEBUG_IMAGE
	},
	"trader": {
		"text": "Exchange bones",
		"image": DEBUG_IMAGE
	},
	"farewell": {
		"text": "Say goodbye to everyone",
		"image": DEBUG_IMAGE
	}
}

var achievements_unlocked = 0

var player_name = ""

func _ready():
	reset()

func reset():
	inventory = {}
	emit_signal("inventory_updated", inventory)
	for achi in achievements.values():
		achi["unlocked"] = false
	achievements_unlocked = 0
	emit_signal("achievements_updated", achievements, 0)
	yield(get_tree(), "idle_frame")
	DialogueController.set_story_variable("achievement_count", 0)

func add_item(name) -> void:
	if has_item(name):
		if name == "Apple":
			unlock_achievement("two_apples")
		print("HEY! Player already has item: %s" %name)
#		return
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
	achievements_unlocked += 1
	AudioController.sfx.play("achievement")
	achievements[name]["unlocked"] = true
	emit_signal("achievements_updated", achievements, achievements_unlocked)
	DialogueController.set_story_variable("achievement_count", achievements_unlocked)

func get_item_texture_by_name(name):
	name = name.to_lower()
	if item_texture_map.has(name):
		return item_texture_map[name]
	print("HEY! Item texture: `%s` not found" %name)
	return DEBUG_IMAGE

func set_player_name(name) -> void:
	player_name = name
	DialogueController.set_story_variable("player_name", name)
