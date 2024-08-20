extends Node

@export var animPlayers: Array[AnimationPlayer] = []
var queue: Array = []
var totalDisplacement: Vector3 = Vector3.ZERO

func AddMoveToQueue(dir: Vector2i, moveType: String, time: float):
	var appendItem: Array
	appendItem = [time, 0, moveType + VectorTools.VectorToString(dir)]
	if(moveType == "Move"):
		appendItem.append(VectorTools.Vec2ToVec3(dir))
		totalDisplacement += appendItem[3]
		queue.append([time, 1, "Green_Move1"])
	queue.append(appendItem)

func AddFallToQueue(dist: int, time: float):
	var appendItem: Array
	appendItem = [time, 2, ("Fall" if (dist >= 0) else "Up") + str(abs(dist)), Vector3(0, -dist, 0)]
	totalDisplacement += appendItem[3]
	queue.append(appendItem)

func ExecuteQueue():
	var newExec: AnimExec = AnimExec.new()
	add_child(newExec)
	newExec.ExecuteQueue(queue.duplicate(), totalDisplacement)
	queue.clear()
	totalDisplacement = Vector3.ZERO

func SkipQueue():
	animPlayers[0].play("RESET")
	animPlayers[1].play("RESET")
	for ii in get_children():
		if(ii.execActive):
			ii.Skip()
