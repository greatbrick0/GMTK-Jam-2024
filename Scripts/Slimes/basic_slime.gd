extends Node

var otherSlimeRef: LittleSlime

func AttemptMove(dir: Vector2):
	if(MoveOneTile(dir)):
		$"../AnimQueue".AddMoveToQueue(dir, "Move", 0.0)
	else:
		if(AttemptMerge(dir)):
			get_parent().MergeWith(otherSlimeRef)
		else:
			$"../AnimQueue".AddMoveToQueue(dir, "Bump", 0.0)
	get_parent().DropHeightLayer()
	SlimeController.CheckForVictory()
	$"../AnimQueue".ExecuteQueue()

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
