extends TileMap

onready var trunks = $Trunks

const TRUNK_TILES_COUNT = 3
const TRUNK_CHANCE = 0.6
const NOISE_SCALE = 10000

func _ready():
	_create_trunks()

func _create_trunks():
	trunks.clear()
	for pos in get_used_cells():
		if not _should_trunk(pos):
			continue
		var created_trunk = false
		for y in [2, 1]:
			for x in [-1, 0, 1]:
				if not get_cellv(pos + Vector2(x, y)):
					_add_trunk(pos)
					created_trunk = true
				if created_trunk:
					break
			if created_trunk:
				break

func _should_trunk(pos: Vector2) -> bool:
	if trunks.get_cellv(pos + Vector2.UP) != -1:
		return false
	if get_cellv(pos) != -1 and \
		get_cellv(pos + Vector2.RIGHT) != -1 and \
		get_cellv(pos + Vector2.LEFT) != -1 and \
		get_cellv(pos + Vector2.UP) != -1 and \
		get_cellv(pos + Vector2(-1, -1)) != -1 and \
		get_cellv(pos + Vector2(1, -1)) != -1:
		return true
	return false

func _add_trunk(pos: Vector2):
#	var noise_pos = pos * NOISE_SCALE
	if Rng.randf() < TRUNK_CHANCE:
#	if Rng.noise01(noise_pos.x ,noise_pos.y) < TRUNK_CHANCE:
		var idx = Rng.randi(0, TRUNK_TILES_COUNT-1)
		trunks.set_cellv(pos, idx)
	
