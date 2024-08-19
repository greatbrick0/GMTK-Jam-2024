extends Node

func AttemptMove(dir: Vector2):
	var didMove: bool = MoveOneTile(dir)
	if(didMove):
		$"../MovePlayer".play("Move" + VectorTools.VectorToString(dir))
		$"../Visuals".position = VectorTools.Vec2ToVec3(-dir)
	else:
		$"../Visuals".position = Vector3.ZERO
		$"../MovePlayer".play("Bump" + VectorTools.VectorToString(dir))
	
	while(IsOnlyAir(get_parent().CheckFacingTiles(dir)) and get_parent().DropHeightLayer() == 0):
		get_parent().MoveTiles(dir)
	SlimeController.CheckForVictory()

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
