extends TileMap


func _ready():
	Global.tilemap = self
	print(get_rand_floor_tile())


func get_rand_tile(layer: int, id: int) -> Vector2:
	var floor_tiles_count = get_used_cells_by_id(layer, id).size()
	var rand_floor_index= randi_range(0, floor_tiles_count - 1)
	var rand_floor_tile = get_used_cells_by_id(layer, id)[rand_floor_index]
	return rand_floor_tile

func get_rand_floor_tile() -> Vector2:
	return get_rand_tile(0, 1)
