extends Node

func AttemptMove(dir: Vector2):
	MoveOneTile(dir)
	MoveOneTile(dir)
	print(get_parent().CheckFacingTiles(dir))
	get_parent().DropHeightLayer()

func MoveOneTile(dir: Vector2):
	if(IsOnlyAir(get_parent().CheckFacingTiles(dir))):
		$"../MovePlayer".play("Move" + VectorTools.VectorToString(dir))
		$"../Visuals".position = VectorTools.Vec2ToVec3(-dir)
		get_parent().MoveTiles(dir)
	else:
		$"../Visuals".position = Vector3.ZERO
		$"../MovePlayer".play("Bump" + VectorTools.VectorToString(dir))

func IsOnlyAir(tiles: Array[String]):
	var output: bool = true
	for ii in tiles:
		if(ii != "Air" and ii != "Goal"):
			output = false
	return output
