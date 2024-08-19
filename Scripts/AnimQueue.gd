extends Node

@export var animPlayers: Array[AnimationPlayer] = []
var queue: Array = []

func AddMoveToQueue(dir: Vector2i, moveType: String, time: float):
	var appendItem: Array = [time, 0, moveType + VectorTools.VectorToString(dir)]
	queue.append(appendItem)

func ExecuteQueue():
	queue.clear()
