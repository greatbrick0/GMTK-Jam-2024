extends SlimeBehaviour

func AttemptMove(dir: Vector2):
	var didMove: bool = MoveOneTile(dir)
	if(didMove):
		$"../AnimQueue".AddMoveToQueue(dir, "Move", 0.0)
	else:
		$"../AnimQueue".AddMoveToQueue(dir, "Bump", 0.0)
	
	var ii: int = 1
	while(didMove and get_parent().DropHeightLayer() == 0):
		didMove = MoveOneTile(dir)
		if(didMove):
			$"../AnimQueue".AddMoveToQueue(dir, "Move", ii * 0.5)
		else:
			$"../AnimQueue".AddMoveToQueue(dir, "Bump", ii * 0.5)
		if(get_parent().DropHeightLayer() > 0):
			didMove = false
		ii += 1
	SlimeController.CheckForVictory()
	$"../AnimQueue".ExecuteQueue()
