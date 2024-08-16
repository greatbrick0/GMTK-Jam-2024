extends Node

func AttemptMove(dir: Vector2):
	get_parent().position += dir
	get_parent().DropHeightLayer()
