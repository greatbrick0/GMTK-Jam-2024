extends Node

func AttemptMove(dir: Vector2):
	if(IsOnlyAir(get_parent().CheckFacingTiles(dir))):
		$"../MovePlayer".play("Move" + VectorTools.VectorToString(dir))
		$"../Visuals".position = VectorTools.Vec2ToVec3(-dir)
		get_parent().MoveTiles(dir)
	get_parent().DropHeightLayer()

func IsOnlyAir(tiles: Array[String]):
	var output: bool = true
	for ii in tiles:
		if(ii != "Air"):
			output = false
	return output
