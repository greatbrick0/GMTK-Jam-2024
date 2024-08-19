extends Node

@export var animPlayers: Array[AnimationPlayer] = []
var queue: Array = []

func AddMoveToQueue(dir: Vector2i, moveType: String, time: float):
	var appendItem: Array
	appendItem = [time, 0, moveType + VectorTools.VectorToString(dir)]
	if(moveType == "Move"):
		appendItem.append(VectorTools.Vec2ToVec3(dir))
		appendItem = [time, 1, "Green_Move1"]
	queue.append(appendItem)

func ExecuteQueue():
	queue.clear()
