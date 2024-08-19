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

func ExecuteQueue():
	var timePassed: float = 0.0
	$"../VisualsOffset".position = -totalDisplacement
	for ii in queue:
		await get_tree().create_timer(ii[0] - timePassed).timeout
		timePassed = ii[0]
		if(ii.size() >= 4): 
			$"../VisualsOffset".position += ii[3]
		animPlayers[ii[1]].play(ii[2])
	queue.clear()
	$"../VisualsOffset".position = Vector3.ZERO
	totalDisplacement = Vector3.ZERO

func SkipQueue():
	queue.clear()
	$"../VisualsOffset".position = Vector3.ZERO
	totalDisplacement = Vector3.ZERO
	for ii in animPlayers:
		ii.play("RESET")
