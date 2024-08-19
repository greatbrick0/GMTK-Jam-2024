extends SlimeBehaviour

func AttemptMove(dir: Vector2):
	if(MoveOneTile(dir)):
		$"../AnimQueue".AddMoveToQueue(dir, "Move", 0.0)
	else:
		$"../AnimQueue".AddMoveToQueue(dir, "Bump", 0.0)
	if(MoveOneTile(dir)):
		$"../AnimQueue".AddMoveToQueue(dir, "Move", 0.5)
	else:
		if(AttemptMerge(dir)):
			get_parent().MergeWith(otherSlimeRef)
		else:
			$"../AnimQueue".AddMoveToQueue(dir, "Bump", 0.5)
	get_parent().DropHeightLayer()
	SlimeController.CheckForVictory()
	$"../AnimQueue".ExecuteQueue()
