extends SlimeBehaviour

func AttemptMove(dir: Vector2):
	var didMove: bool = MoveOneTile(dir)
	if(didMove):
		$"../AnimQueue".AddMoveToQueue(dir, "Move", 0.0)
	else:
		if(AttemptMerge(dir)):
			get_parent().MergeWith(otherSlimeRef)
		else:
			AttemptBreak(dir)
			$"../AnimQueue".AddMoveToQueue(dir, "Bump", 0.0)
	
	var ii: int = 1
	var fallDist: int = get_parent().DropHeightLayer()
	if(fallDist != 0):
			didMove = false
			$"../AnimQueue".AddFallToQueue(fallDist, (ii + 1) * 0.5)
	
	while(didMove):
		didMove = MoveOneTile(dir)
		if(didMove):
			$"../AnimQueue".AddMoveToQueue(dir, "Move", ii * 0.5)
		else:
			$"../AnimQueue".AddMoveToQueue(dir, "Bump", ii * 0.5)
		fallDist = get_parent().DropHeightLayer()
		if(fallDist != 0):
			didMove = false
			$"../AnimQueue".AddFallToQueue(fallDist, (ii + 1) * 0.5)
		ii += 1
	
	SlimeController.CheckForVictory()
	$"../AnimQueue".ExecuteQueue()
