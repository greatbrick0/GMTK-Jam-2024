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
