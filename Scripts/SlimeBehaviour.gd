extends Node
class_name SlimeBehaviour

var otherSlimeRef: LittleSlime

func MoveOneTile(dir: Vector2) -> bool:
	if(IsOnlyAir(get_parent().CheckFacingTiles(dir))):
		get_parent().MoveTiles(dir)
		return true
	else:
		return false

func IsOnlyAir(tiles: Array[String]):
	var output: bool = true
	for ii in tiles:
		if(ii != "Air" and ii != "Goal"):
			output = false
	return output

func AttemptMerge(dir: Vector2i) -> bool:
	if(get_parent().isBig): return false
	if(get_parent().isDead): return false
	if(get_parent().CheckFacingTiles(dir)[0] != "LittleSlime"): return false
	
	otherSlimeRef = get_parent().GetTileScene(dir, 0)
	if(otherSlimeRef.isDead): return false
	return otherSlimeRef.CheckForExpand()

func AttemptBreak(dir: Vector2i):
	var perpDir: Vector2i = VectorTools.Perpendicular(dir)
	perpDir = perpDir / perpDir.length()
	
	var breakTiles: Array[Vector2i]
	if(get_parent().isBig):
		breakTiles = [dir + dir + perpDir, dir + dir, dir + dir - perpDir]
	else:
		breakTiles = [dir]
		
	for ii in breakTiles:
		if(get_parent().CheckTile(ii) == "Box"):
			get_parent().GetTileScene(ii, 0).Break()
