extends Node

func AttemptMove(dir: Vector2):
	get_parent().MoveTiles(dir)
	get_parent().MoveTiles(dir)
	get_parent().DropHeightLayer()
