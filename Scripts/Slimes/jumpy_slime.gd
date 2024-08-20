extends SlimeBehaviour

func AttemptMove(dir: Vector2):
	var didMerge: bool = false
	if(MoveOneTile(dir)):
		$"../AnimQueue".AddMoveToQueue(dir, "Move", 0.0)
	else:
		$"../AnimQueue".AddMoveToQueue(dir, "Bump", 0.0)
	if(MoveOneTile(dir)):
		$"../AnimQueue".AddMoveToQueue(dir, "Move", 0.5)
	else:
		didMerge = AttemptMerge(dir)
		if(didMerge):
			get_parent().MergeWith(otherSlimeRef)
		else:
			$"../AnimQueue".AddMoveToQueue(dir, "Bump", 0.5)
	
	if(!didMerge):
		var fallDist: int = get_parent().DropHeightLayer()
		if(fallDist != 0): $"../AnimQueue".AddFallToQueue(fallDist, 1.0)
	SlimeController.CheckForVictory()
	$"../AnimQueue".ExecuteQueue()
