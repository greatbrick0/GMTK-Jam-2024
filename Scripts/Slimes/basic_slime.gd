extends Node

func AttemptMove(dir: Vector2):
	if(MoveOneTile(dir)):
		$"../AnimQueue".AddMoveToQueue(dir, "Move", 0.0)
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
