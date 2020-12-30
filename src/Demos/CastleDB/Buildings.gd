extends TileMap

func _ready():
	_read_db_data()

func _read_db_data():
	var db = TestDb.buildings
	# Iterate DB items
	for i in db.all.size():
		var building = db.get_index(i)
		print("%s costs %s" % [building.id, building.price])
	# Get DB item
	var building = db.get(TestDb.Buildings.house)
	print("Item %s image path is: %s" % [building.id, building.image_path])
