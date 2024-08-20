extends SlimeBehaviour

func AttemptMove(dir: Vector2):
	
	
	if(MoveOneTile(dir)):
		$"../AnimQueue".AddMoveToQueue(dir, "Move", 0.0)
	else:
		if(AttemptMerge(dir)):
			get_parent().MergeWith(otherSlimeRef)
		else:
			AttemptBreak(dir)
			$"../AnimQueue".AddMoveToQueue(dir, "Bump", 0.0)
	
	var fallDist: int = get_parent().DropHeightLayer()
	if(fallDist != 0): $"../AnimQueue".AddFallToQueue(fallDist, 0.5)
	SlimeController.CheckForVictory()
	$"../AnimQueue".ExecuteQueue()

func AttemptBreak(dir: Vector2i):
	var perpDir: Vector2i = VectorTools.Perpendicular(dir)
	perpDir = perpDir / perpDir.length()
	
	var breakTiles: Array[Vector2i]
	if(get_parent().isBig):
		breakTiles = [dir + dir + perpDir, dir + dir, dir + dir - perpDir]
	else:
		breakTiles = [dir]
		
	for ii in breakTiles:
		print(get_parent().CheckTile(ii))
		if(get_parent().CheckTile(ii) == "Box"):
			get_parent().GetTileScene(ii, 0).Break()
