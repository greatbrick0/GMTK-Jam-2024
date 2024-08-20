extends SlimeBehaviour

func AttemptMove(dir: Vector2):
	var didMove: bool = MoveOneTile(dir)
	if(didMove):
		$"../AnimQueue".AddMoveToQueue(dir, "Move", 0.0)
	else:
		if(AttemptMerge(dir)):
			get_parent().MergeWith(otherSlimeRef)
		else:
			$"../AnimQueue".AddMoveToQueue(dir, "Bump", 0.0)
	
	var fallDist: int
	var ii: int = 1
	while(didMove):
		didMove = MoveOneTile(dir)
		if(didMove):
			$"../AnimQueue".AddMoveToQueue(dir, "Move", ii * 0.5)
		else:
			$"../AnimQueue".AddMoveToQueue(dir, "Bump", ii * 0.5)
		
		if(!get_parent().CheckForGround() and !CheckForWalls(dir)):
			fallDist = get_parent().DropHeightLayer()
			if(fallDist != 0):
				didMove = false
				$"../AnimQueue".AddFallToQueue(fallDist, (ii + 1) * 0.5)
		ii += 1
	
	fallDist = get_parent().DropHeightLayer()
	if(fallDist != 0): $"../AnimQueue".AddFallToQueue(fallDist, (ii + 1) * 0.5)
	
	SlimeController.CheckForVictory()
	$"../AnimQueue".ExecuteQueue()

func CheckForWalls(dir: Vector2i) -> bool:
	for ii in range(1, 20):
		if(!IsOnlyAir(get_parent().CheckFacingTiles(dir * ii))):
			return true
	return false
