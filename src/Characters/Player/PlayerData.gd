extends Node

signal inventory_updated(inv)
signal achievements_updated(ach, count, unlocked_achi)

# name -> image
var inventory = {}

var DEBUG_IMAGE = preload("res://assets/art/debug/rect_16.png")

# name -> image
var item_texture_map = {
	"oregano": preload("res://assets/art/ola/items/oregano.png"),
	"apple": preload("res://assets/art/ola/items/apple.png"),
	"bone": preload("res://assets/art/ola/items/bone.png"),
	"fish": preload("res://assets/art/ola/items/fish.png"),
	"fishbone": preload("res://assets/art/ola/items/fish_bone.png"),
	"pussy": preload("res://assets/art/ola/items/pussy.png"),
	"worm": preload("res://assets/art/ola/items/worm_pile.png"),
	# Achievements
	"dog_bone_ach": preload("res://assets/art/ola/ach/dog_bone_ach.png"),
	"farewell_ach": preload("res://assets/art/ola/ach/farewell_ach.png"),
	"good_heart_ach": preload("res://assets/art/ola/ach/good_heart_ach.png"),
	"oregano_ach": preload("res://assets/art/ola/ach/oregano_ach.png"),
	"patient_ach": preload("res://assets/art/ola/ach/patient_ach.png"),
	"pussy_ach": preload("res://assets/art/ola/ach/pussy_ach.png"),
	"quiz_ach": preload("res://assets/art/ola/ach/quiz_won_ach.png"),
	"trader_ach": preload("res://assets/art/ola/ach/trader_ach.png"),
	"two_apple_ach": preload("res://assets/art/ola/ach/two_apple_ach.png"),
}

var achievements = {
	"oregano": {
		"text": "Help make the best spaghetti ever",
		"image": get_item_texture_by_name("oregano_ach"),
#		"unlocked" = true,
	},
	"good_heart": {
		"text": "Share food with someone in need",
		"image": get_item_texture_by_name("good_heart_ach"),
	},
	"two_apples": {
		"text": "2 apples a day...",
		"image": get_item_texture_by_name("two_apple_ach")
	},
	"quiz_won": {
		"text": "Complete dinosaur knowledge quiz",
		"image": get_item_texture_by_name("quiz_ach")
	},
	"patient": {
		"text": "Be patient",
		"image": get_item_texture_by_name("patient_ach")
	},
	"pussy": {
		"text": "Bring Pussy home",
		"image": get_item_texture_by_name("pussy_ach")
	},
	"dog_bone": {
		"text": "Give bone to Benjamin",
		"image": get_item_texture_by_name("dog_bone_ach")
	},
	"trader": {
		"text": "Exchange bones",
		"image": get_item_texture_by_name("trader_ach")
	},
	"farewell": {
		"text": "Say goodbye to everyone",
		"image": get_item_texture_by_name("farewell_ach")
	}
}

var achievements_unlocked = 0

var player_name = ""

func _ready():
	reset()
#	# FOR TESTING, unlock all achievements
#	for achi in achievements.keys():
#		achievements[achi]["unlocked"] = true

func reset():
	inventory = {}
	emit_signal("inventory_updated", inventory)
	for achi in achievements.values():
		achi["unlocked"] = false
	achievements_unlocked = 0
	emit_signal("achievements_updated", achievements, 0, null)
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
	yield(get_tree().create_timer(0.2), "timeout")
	AudioController.sfx.play("pop")

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
	emit_signal("achievements_updated", achievements, achievements_unlocked, achievements[name])
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

func get_unlocked_achievements() -> Array:
	var unlocked = []
	for achi in achievements.values():
		if achi["unlocked"]:
			unlocked.append(achi)
	return unlocked
