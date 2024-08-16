extends Node3D

func ReadTile(pos: Vector2i, height: int) -> String:
	var tile: String
	var tileData: TileData = $TileMap.get_cell_tile_data(height, pos)
	if(tileData == null):
		tile = "Air"
	else:
		tile = tileData.get_custom_data("GroundType")
	
	if(tile == "Air"):
		pass
	
	return tile
