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
	if(get_parent().CheckFacingTiles(dir)[0] != "LittleSlime"): return false
	
	otherSlimeRef = get_parent().GetTileScene(dir, 0)
	return otherSlimeRef.CheckForExpand()
