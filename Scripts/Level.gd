extends Node3D

func ReadTile(pos: Vector2i, height: int):
	$TileMap.get_cell_tile_data(height, pos)
	pass
