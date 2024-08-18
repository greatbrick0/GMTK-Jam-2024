extends Node3D

var tileScenes: Dictionary
var directionVectors: Array[Vector2i] = [
	Vector2i.UP, 
	Vector2i.UP + Vector2i.LEFT,
	Vector2i.LEFT,
	-Vector2i.UP + Vector2i.LEFT,
	-Vector2i.UP,
	-Vector2i.UP - Vector2i.LEFT,
	-Vector2i.LEFT,
	Vector2i.UP - Vector2i.LEFT
	]

func _ready():
	$TileMap.visible = false

func ReadTile(pos: Vector2i, height: int) -> String:
	var tile: String
	var tileData: TileData = $TileMap.get_cell_tile_data(height, pos)
	
	if(tileData == null): tile = "Air"
	else: tile = tileData.get_custom_data("GroundType")
	
	if(tile == "Air"): tile = FindByPosition(pos, height)
	
	return tile

func FindByPosition(pos: Vector2i, height: int) -> String:
	var output: String = "Air"
	for ii in tileScenes.values():
		if(ii[0] == pos && ii[1] == height):
			output = ii[2]
	return output

func AddTileScene(sceneType: String, pos: Vector2i, height: int, key: Node3D):
	tileScenes[key] = [pos, height, sceneType]
	if(sceneType == "BigSlime"):
		for ii in range(directionVectors.size()):
			tileScenes[[key, ii]] = [pos + directionVectors[ii], height, sceneType]

func MoveTileScene(key: Node3D, pos: Vector2i, height: int):
	var sceneType: String = tileScenes[key][2]
	tileScenes[key] = [pos, height, sceneType]
	if(sceneType == "BigSlime"):
		for ii in range(directionVectors.size()):
			tileScenes[[key, ii]] = [pos + directionVectors[ii], height, sceneType]
